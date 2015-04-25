require 'spec_helper'
require 'pact/init/provider'

describe Pact::Init::Provider do

  describe '.call' do
    let(:spec_dir) { 'tmp/specz' }
    let(:consumer_dir) { 'tmp/specz/service_consumers' }
    let(:pact_helper_file) { consumer_dir + '/' + 'pact_helper.rb' }
    let(:provider_states_file) { consumer_dir + '/' + 'provider_states_for_my_consumer.rb' }
    let(:arguments) { {spec_dir: spec_dir} }

    before do
      FileUtils.rm_rf('tmp/specz')
      Pact::Init::Provider.call arguments
    end

    context 'when no arguments are specified' do

      it 'creates the directory' do
        expect(Dir.exists?(consumer_dir)).to eq(true)
      end

      it 'creates the helper files' do
        expect(File.exists?(pact_helper_file)).to eq(true)
        expect(File.exists?(provider_states_file)).to eq(true)
      end

      it 'generates the sample pact_helper code with default consumer provider names' do
         expected = File.read('spec/fixtures/provider/pact_helper.rb')
         actual = File.read(pact_helper_file)
         expect(actual).to eq(expected)
      end

      it 'generates the sample provider_states code with default consumer name' do
        expected = File.read('spec/fixtures/provider/provider_states_for_my_consumer.rb')
        actual = File.read(provider_states_file)
        expect(actual).to eq(expected)
      end
    end

    context 'when provider and consumer args are specified' do
      let(:provider) {'Bar Provider'}
      let(:consumer) {'Foo Consumer'}
      let(:arguments) { {provider: provider , consumer: consumer, spec_dir: spec_dir} }


      it 'create the directory' do
        expect(Dir.exists?(consumer_dir)).to eq(true)
      end

      it 'creates the helper files' do
        expect(File.exists?(pact_helper_file)).to eq(true)
        expect(File.exists?(provider_states_file)).to eq(true)
      end

      it 'generates the sample pact_helper code with the given provider and consumer names' do
        expected = File.read('spec/fixtures/provider/pact_helper_custom.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

      it 'generates the sample provider_states code with given consumer name' do
        expected = File.read('spec/fixtures/provider/provider_states_for_custom_consumer.rb')
        actual = File.read(provider_states_file)
        expect(actual).to eq(expected)
      end
    end

    context 'when either of the arguments have been given with leading and traliing white space' do
      let(:consumer) { '    Foo Consumer     ' }
      let(:provider) { '    Bar Provider     ' }

      let(:arguments) { {consumer: consumer, provider: provider, spec_dir: spec_dir} }

      it 'strips the white space from both ends' do
        expected = File.read('spec/fixtures/provider/pact_helper_custom.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end

  end

end
