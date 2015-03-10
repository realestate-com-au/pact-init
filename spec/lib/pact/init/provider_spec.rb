require 'spec_helper'
require 'pact/init/provider'

describe Pact::Init::Provider do
  describe '#new' do
  	let(:consumer_dir) { 'specz/some_consumer_dir' }
    let(:pact_helper_file) { consumer_dir + '/' + 'pact_helper.rb' }

    before do
      allow_any_instance_of(Pact::Init::Provider).to receive(:consumer_dir).and_return(consumer_dir)
      expect(Dir.exists?(consumer_dir)).to eq(false)
    end

    after do
      FileUtils.rm_rf('specz')
    end

  	context 'when no arguments are specified' do
      before { Pact::Init::Provider.run }

      it 'creates the directory' do
        expect(Dir.exists?(consumer_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates the sample code with default consumer provider names' do
         expected = File.read('spec/fixtures/provider/pact_helper_provider.rb')
         actual = File.read(pact_helper_file)
         expect(actual).to eq(expected)
      end

    end

    context 'when provider arg is specified only' do
      let(:provider) { 'Bar Provider' }
      let(:just_provider_args) { {provider: provider} }

      before { Pact::Init::Provider.run(just_provider_args) }

      it 'creates the directory' do
        expect(Dir.exists?(consumer_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates sample code with given provider name and default consumer name' do
        expected = File.read('spec/fixtures/provider/pact_helper_custom_provider.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end
    end

  end

end