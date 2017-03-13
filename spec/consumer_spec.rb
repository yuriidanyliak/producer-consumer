require_relative '../lib/consumer'

RSpec.describe ProducerConsumer::Consumer do
  let(:logger) { double(info: true) }
  let(:queue) { double(pop: 1) }
  let(:instance) { described_class.new(logger, queue) }
  let(:run_consumer) { instance.run }

  before { allow(instance).to receive(:loop).and_yield }

  it 'fetches item from the queue' do
    run_consumer

    expect(queue).to have_received(:pop)
  end

  it 'notifies logger' do
    run_consumer

    expect(logger).to have_received(:info).with('Consumed item #1')
  end
end
