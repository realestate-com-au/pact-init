require 'spec_helper'
require 'pact/init/consumer'

describe Pact::Init::Consumer do

  describe '.call' do

    let(:spec_dir) { 'tmp/specz' }
    let(:provider_dir) { 'tmp/specz/service_providers' }
    let(:pact_helper_file) { provider_dir + '/' + 'pact_helper.rb' }
    let(:arguments) { { spec_dir: spec_dir } }

    before do
      FileUtils.rm_rf('tmp/specz')
      Pact::Init::Consumer.call arguments
    end

    context 'when no arguments are specified' do

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the helper file' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates the sample code with default consumer provider names' do
        expected = File.read('spec/fixtures/consumer/pact_helper.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end

    context 'when consumer and provider args are specified' do
      let(:consumer) { 'Foo Consumer' }
      let(:provider) { 'Bar Provider' }

      let(:arguments) { {consumer: consumer, provider: provider, spec_dir: spec_dir} }

      it 'creates the directory' do
        expect(Dir.exists?(provider_dir)).to eq(true)
      end

      it 'creates the file with the given names' do
        expect(File.exists?(pact_helper_file)).to eq(true)
      end

      it 'generates sample code with given consumer provider names' do
        expected = File.read('spec/fixtures/consumer/pact_helper_custom.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end

    end

    context 'when either of the arguments have been given with leading and traliing white space' do
      let(:consumer) { '    Foo Consumer     ' }
      let(:provider) { '    Bar Provider     ' }

      let(:arguments) { {consumer: consumer, provider: provider, spec_dir: spec_dir} }

      it 'strips the white space from both ends' do
        expected = File.read('spec/fixtures/consumer/pact_helper_custom.rb')
        actual = File.read(pact_helper_file)
        expect(actual).to eq(expected)
      end
    end

    context 'when the provider name has a dash in it' do

      let(:provider) { 'Bar-Provider' }

      let(:arguments) { {provider: provider, spec_dir: spec_dir} }

      it 'is replaced with an underscore when creating the mock service name' do
        expect(File.read(pact_helper_file)).to include 'mock_service :bar_provider do'
      end
    end
  end
end
