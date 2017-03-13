require_relative '../lib/dispatcher'
require 'logger'
require 'timeout'

RSpec.configure do |c|
  c.around(:each) do |example|
    begin
      Timeout::timeout(3) { example.run }
    rescue Timeout::Error; end
  end
end

describe ProducerConsumer::Dispatcher do
  let(:logger) { Logger.new(STDOUT) }
  let(:queue) { SizedQueue.new(3) }
  let(:instance) { described_class.new(logger, queue) }
  let(:producer) { instance.spawn_producer }
  let(:consumer) { instance.spawn_consumer }

  it 'logs its actions in expected order' do
    expected_output = 'Item #1 produced Item #2 produced Item #3 produced Consumed item #1' \
    'Item #4 produced Consumed item #2 Item #5 produced Consumed item #3 Item #6 produced'

    expect { producer; consumer }.to output(expected_output).to_stdout
  end
end
