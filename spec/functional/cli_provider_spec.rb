require 'spec_helper'
require 'pact/init/consumer'

describe 'The pact-init-provider command line interface' do

  before do
    FileUtils.mkdir_p('test')
    Dir.chdir('test')
  end

  after do
    Dir.chdir('..')
    FileUtils.rm_rf('test')
  end

  context 'no arguments' do

    it 'creates the desired files and folder structure' do
      %x(bundle exec ../bin/pact-init-provider)
      expect(Dir.exists?('spec/service_consumers')).to eq(true)
      expect(File.exists?('spec/service_consumers/pact_helper.rb')).to eq(true)
      expect(File.read('spec/service_consumers/pact_helper.rb')).to eq(File.read('../spec/fixtures/provider/pact_helper.rb'))
    end

  end

  context 'with consumer and provider argument' do

    it 'creates the desired files and folder structure' do
      %x(bundle exec ../bin/pact-init-provider --consumer \" Foo Consumer\" --provider \" Bar Provider \")
      expect(Dir.exists?('spec/service_consumers')).to eq(true)
      expect(File.exists?('spec/service_consumers/pact_helper.rb')).to eq(true)
      expect(File.read('spec/service_consumers/pact_helper.rb')).to eq(File.read('../spec/fixtures/provider/pact_helper_custom.rb'))
    end

  end

end
