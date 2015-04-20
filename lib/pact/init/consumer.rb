require 'erb'

module Pact
  module Init
    class Consumer

      def self.call(names = {})
        new.run(names)
      end

      def run(names)
        @names = parse_names(names)
        create_directory
        create_files
        generate_pact_helper
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

      def generate_pact_helper
        template_string = File.read(File.expand_path( '../templates/consumer/pact_helper.erb', __FILE__))
        render = ERB.new(template_string).result(binding)
        File.open(provider_dir+'/'+'pact_helper.rb', "w+"){ |f| f.write(render) }
      end

      def parse_names(names)
        names[:consumer] ||= 'My Consumer' unless names.has_key? :consumer
        names[:provider] ||= 'My Provider' unless names.has_key? :provider
        names
      end
    end
  end
end
