class PetticoatJunction
  class Queue
    DEFAULT_QUEUES = [:new,:active,:stale]
    
    def initialize(ns,name)
      @name = name
      @ns = ns
      @queue_name = "#{ns}_#{name}"
    end

    attr_reader :name, :ns, :queue_name
    
    def add(term)
      terms = term.is_a?(Array) ? term : [term]
      terms.each do |t|
        PetticoatJunction::STARLING.set(@queue_name, t.id)
        t.update_queued_at(@ns)
      end
    rescue MemCache::MemCacheError
      puts 'MemCacheError.  Starling is down?'
      # retry # not sure if this is a good idea...
    end

    alias :<< :add
    
    def pop
      PetticoatJunction::STARLING.fetch(@queue_name)
    rescue MemCache::MemCacheError
      puts 'MemCacheError.  Starling is down?'
    end
  end

  class << self
    def queue(ns,name)
      q = Queue.new(ns, name)

      @queues ||= {}
      @queues[ns] ||= {}
      @queues[ns][name] = q

      meta_def(ns) { |qname|
        return unless qname
        @queues[ns][qname]
      } unless self.respond_to?(ns)
    end

    attr_accessor :queues

    private

    def inherited(subclass)
      ns = subclass.to_s.underscore.to_sym
      Queue::DEFAULT_QUEUES.each { |q| queue ns, q }
    end
  end
end

