require 'byebug'
require 'erb'

module Pact
  module Init
    class Provider

      def self.run(names = {})
        new.run(names)
      end

    	def run(names)
        @names = parse_names(names)
    		create_directory
        create_files
    		generate_pact_helper
    	end

    	def create_directory
    		FileUtils.mkdir_p(consumer_dir)
      end

      def create_files
        FileUtils.touch(consumer_dir+'/'+'pact_helper.rb')
      end

      def consumer_dir
        	'spec/service_consumers'
      end

      def generate_pact_helper
        template_string = File.read(File.expand_path( '../templates/provider/pact_helper.erb', __FILE__))
        render = ERB.new(template_string).result(binding)
        File.open(consumer_dir+'/'+'pact_helper.rb', "w+"){ |f| f.write(render) }
      end

      def parse_names(names)
        names[:consumer] = 'My Consumer' unless names.has_key? :consumer
        names[:provider] = 'My Provider' unless names.has_key? :provider
        names
      end

    end
  end
end