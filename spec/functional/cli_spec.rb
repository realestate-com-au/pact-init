require 'spec_helper'
require 'pact/init/consumer'

describe 'The pact-init-consumer command line interface' do

  context 'no arguments' do

    before do
      FileUtils.mkdir_p('test')
      Dir.chdir('test')
    end

    after do
      Dir.chdir('..')
      FileUtils.rm_rf('test')
    end

    it 'creates the desired files and folder structure' do
      %x(bundle exec ../bin/pact-init-consumer)
      expect(Dir.exists?('spec/service_providers')).to eq(true)
      expect(File.exists?('spec/service_providers/pact_helper.rb')).to eq(true)
      expect(File.read('spec/service_providers/pact_helper.rb')).to eq(File.read('../spec/fixtures/pact_helper.rb'))
    end
  end

end
