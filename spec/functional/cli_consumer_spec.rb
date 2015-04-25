require 'spec_helper'
require 'pact/init/consumer'

describe 'The pact-init-consumer command line interface' do

  before do
    FileUtils.rm_rf('tmp')
    FileUtils.mkdir_p('tmp')
  end

  context 'no arguments' do

    it 'creates the desired files and folder structure' do
      Dir.chdir('tmp') do
        %x(bundle exec ../bin/pact-init-consumer)
        expect(Dir.exists?('spec/service_providers')).to eq(true)
        expect(File.exists?('spec/service_providers/pact_helper.rb')).to eq(true)
        expect(File.exists?('spec/service_providers/pact_helper.rb')).to eq(true)
      end
    end

  end

  context 'with consumer and provider argument' do

    it 'creates the desired files and folder structure' do
      Dir.chdir('tmp') do
        %x(bundle exec ../bin/pact-init-consumer --consumer \" Foo Consumer\" --provider \" Bar Provider \")
        expect(Dir.exists?('spec/service_providers')).to eq(true)
        expect(File.exists?('spec/service_providers/pact_helper.rb')).to eq(true)
        expect(File.exists?('spec/service_providers/pact_helper.rb')).to eq(true)
      end
    end

  end

end
