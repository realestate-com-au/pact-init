require 'spec_helper'
require 'pact/init/consumer'

describe 'The pact-init-consumer command line interface' do

  let(:pact_helper_path) { 'tmp/spec/service_providers/pact_helper.rb' }
  let(:pact_helper_content) { File.read(pact_helper_path) }

  before do
    FileUtils.rm_rf('tmp')
    FileUtils.mkdir_p('tmp')
  end

  context 'with no arguments' do

    before do
      Dir.chdir('tmp') do
        %x(bundle exec ../bin/pact-init-consumer)
      end
    end

    it 'creates the desired files and folder structure' do
      expect(pact_helper_content).to match("Pact.service_consumer")
    end

  end

  context 'with consumer and provider argument' do

    before do
      Dir.chdir('tmp') do
        %x(bundle exec ../bin/pact-init-consumer --consumer \" Foo Consumer\" --provider \" Bar Provider \")
      end
    end

    it 'creates the desired files and folder structure' do
      expect(pact_helper_content).to match("Pact.service_consumer")
      expect(pact_helper_content).to match("Foo Consumer")
      expect(pact_helper_content).to match("Bar Provider")
    end

  end

end
