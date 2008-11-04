class PetticoatJunction
  class Monitor < Base
    class << self

      private

      def rate(queue, rates)
        @@queue_churn_rates ||= {}
        @@queue_churn_rates[queue] = rates
      end

      @@pause = 10
    end

    private

    def churn
      loop do
        @@queue_churn_rates.each { |name,attrs| add_to_queue name, latest_terms(attrs) }
        sleep @@pause || 10
      end
    rescue => e
      puts e.message
      puts e.backtrace
      puts
      sleep 5
      retry
    end

    def latest_terms(attrs)
      ::Term.need_updated(namespace, attrs[:refresh].ago, attrs[:threshold].ago)
    end

    def add_to_queue(name,terms)
      PetticoatJunction.queues[namespace][name] << terms
    end
  end
end

