class PetticoatJunction
  class Search < Base

    class << self
      def pause(seconds)
        @@pause = seconds
      end
    end
    
    def initialize
      @churn = Thread.new { churn }
    end

    def churn
      loop do
        term = ::Term.find(next_term)

        search term
        term.update_searched_at(@@namespace.to_s)

        sleep @@pause ? @@pause.to_i : 1
      end
    rescue Mysql::Error => e
      puts e.message
      puts 'Attempting to reconnect...'
      ActiveRecord::Base.establish_connection
    rescue => e
      puts e.message
      puts e.backtrace
      sleep 5
      retry
    end

    def next_term
      loop do
        PetticoatJunction::Queue::DEFAULT_QUEUES.each do |q|
          term_id = PetticoatJunction.queues[@@namespace][q].pop
          return term_id if term_id
        end
        sleep 1
      end
    end

    def search(term)
      raise 'The #search method must be overridden in subclasses of Petticoat::Search'
    end
  end
end

