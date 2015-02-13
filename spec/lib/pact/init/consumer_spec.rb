require 'spec_helper'
require 'pact/init/consumer'

describe Pact::Init::Consumer do
  describe '#new' do

    let(:provider_dir) { 'specz/some_provider_dir' }
    let(:pact_helper_file) { provider_dir + '/' + 'pact_helper.rb' }

    before do
      allow_any_instance_of(Pact::Init::Consumer).to receive(:provider_dir).and_return(provider_dir)
      expect(Dir.exists?(provider_dir)).to eq(false)
    end

    after do
      FileUtils.rm_rf('specz')
    end

    context 'when no arguments are specified' do
      before { Pact::Init::Consumer.run }

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates the sample code with default consumer provider names' do
        expected = File.read('spec/fixtures/pact_helper.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end
    end

    context 'when consumer and provider args are specified' do

      xit 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      xit 'creates the file with the given names' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      xit 'generates sample code with given consumer provider names' do


      end

    end

    context 'when consumer arg is specified only' do
      let(:consumer) { 'Foo' }
      before { Pact::Init::Consumer.run(consumer) }

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates sample code with given consumer name and default provider name' do
        expected = File.read('spec/fixtures/pact_helper_custom_consumer.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end

    context 'when provider arg is specified only' do

      xit 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      xit 'creates the helper file' do

      end

      xit 'generates sample code with given provider name and default consumer name' do

      end

    end

end

end
