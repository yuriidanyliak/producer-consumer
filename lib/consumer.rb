module ProducerConsumer
  class Consumer
    def initialize(logger, queue)
      @logger = logger
      @queue = queue
    end

    def run
      start_infinite_loop
    end

    private

    def start_infinite_loop
      loop do
        publish_notification(@queue.pop)
        sleep 1
      end
    end

    def publish_notification(item)
      @logger.info "Consumed item ##{item}"
    end
  end
end

