class PetticoatJunction
  class Base
    class << self
      def start
        return unless @heirs
        
        puts "Starting threads..."
        @monitors = @heirs.map { |h| h.new }

        # I wish I didn't need to have KILL in here.  But the daemons library use
        # KILL (9) to stop or restart processes.
        %w(INT KILL TERM).each { |s| Signal.trap(s,&die) }

        Thread.stop
      end

      def stop
        return unless @monitors
        @monitors.each { |m| m.stop }
      end

      def die
        lambda do
          print 'Stopping threads...'
          stop
          puts 'OK'
          exit
        end
      end

      attr_reader :heirs
      
      private

      def inherited(subclass)
        subclass.namespace = subclass.to_s.split('::')[0].underscore.to_sym
        register subclass
      end
      
      def register(subclass)
        @heirs ||= []
        @heirs << subclass
      end

      protected

      def namespace=(ns)
        @@namespace = ns
      end      
    end

    def initialize
      @churn = Thread.new { churn }
    end

    def stop
      return unless @churn.is_a?(Thread)
      return unless @churn.alive?
      @churn.kill
    end

    def namespace
      @@namespace
    end
  end
end

