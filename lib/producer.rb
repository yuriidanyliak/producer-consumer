module ProducerConsumer
  class Producer
    def initialize(logger, queue)
      @logger = logger
      @queue = queue
      @item = 0
    end

    def run
      start_infinite_loop
    end

    private

    def start_infinite_loop
      loop do
        @queue.push register_new_item
        publish_notification
      end
    end

    def register_new_item
      @item += 1
    end

    def publish_notification
      @logger.info "Item ##{@item} produced"
    end
  end
end
