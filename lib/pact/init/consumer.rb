require 'erb'

module Pact
  module Init
    class Consumer

      def self.run(consumer = 'My Consumer')
        new.run(consumer)
      end

      def run(consumer)
        create_directory
        create_files
        generate_pact_helper consumer
      end

      def create_directory
        FileUtils.mkdir_p(provider_dir)
      end

      def provider_dir
        'spec/service_providers'
      end

      def create_files
        FileUtils.touch(provider_dir+'/'+'pact_helper.rb')
      end

      def generate_pact_helper(consumer)
        template_string = File.read(File.expand_path( '../templates/pact_helper.erb', __FILE__))
        render = ERB.new(template_string).result(binding)
        File.open(provider_dir+'/'+'pact_helper.rb', "w+"){ |f| f.write(render) }
      end

    end
  end
end
