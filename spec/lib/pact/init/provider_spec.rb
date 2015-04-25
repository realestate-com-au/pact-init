  require 'spec_helper'
  require 'pact/init/provider'

  describe Pact::Init::Provider do
    describe '#new' do
      let(:consumer_dir) { 'tmp/specz/some_consumer_dir' }
      let(:pact_helper_file) { consumer_dir + '/' + 'pact_helper.rb' }
      let(:provider_states_file) { consumer_dir + '/' + 'provider_states_for_my_consumer.rb' }

      before do
        allow_any_instance_of(Pact::Init::Provider).to receive(:consumer_dir).and_return(consumer_dir)
        FileUtils.rm_rf('tmp/specz')
      end

      context 'when no arguments are specified' do
        before { Pact::Init::Provider.call }

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

      context 'when provider arg is specified only' do
        let(:provider) { 'Bar Provider' }
        let(:just_provider_args) { {provider: provider} }

        before { Pact::Init::Provider.call(just_provider_args) }

        it 'creates the directory' do
          expect(Dir.exists?(consumer_dir)).to eq(true)
        end

        it 'creates the helper files' do
          expect(File.exists?(pact_helper_file)).to eq(true)
          expect(File.exists?(provider_states_file)).to eq(true)
        end

        it 'generates sample pact_helper code with given provider name and default consumer name' do
          expected = File.read('spec/fixtures/provider/pact_helper_custom_provider.rb')
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
        let(:both_args) { {provider: provider , consumer: consumer} }

        before { Pact::Init::Provider.call(both_args) }

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

        let(:consumer_and_provider_args) { {consumer: consumer, provider: provider} }

        before { Pact::Init::Provider.call(consumer_and_provider_args) }

        it 'strips the white space from both ends' do
          expected = File.read('spec/fixtures/provider/pact_helper_custom.rb')
          actual = File.read(pact_helper_file)
          expect(actual).to eq(expected)
        end

      end

    end

  end
