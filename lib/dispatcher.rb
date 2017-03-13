require_relative 'producer'
require_relative 'consumer'

module ProducerConsumer
  class Dispatcher
    def initialize(logger, queue)
      @logger = logger
      @queue = queue
    end

    def spawn_producer
      Thread.new { producer.run }
    end

    def spawn_consumer
      Thread.new { consumer.run }.join
    end

    private

    def producer
      Producer.new(@logger, @queue)
    end

    def consumer
      Consumer.new(@logger, @queue)
    end
  end
end
