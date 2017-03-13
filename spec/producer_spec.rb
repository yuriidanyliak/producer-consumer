require_relative '../lib/producer'

RSpec.describe ProducerConsumer::Producer do
  let(:logger) { double(info: true) }
  let(:queue) { double(push: nil) }
  let(:instance) { described_class.new(logger, queue) }
  let(:run_producer) { instance.run }

  before { allow(instance).to receive(:loop).and_yield }

  it 'pushes new item to queue' do
    run_producer

    expect(queue).to have_received(:push).with(1)
  end

  it 'notifies logger' do
    run_producer

    expect(logger).to have_received(:info).with('Item #1 produced')
  end
end
