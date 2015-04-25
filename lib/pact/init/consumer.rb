require 'erb'

module Pact
  module Init
    class Consumer

      def self.call(options = {})
        new.run(options)
      end

      def run(options)
        @options = parse_options(options)
        @spec_dir = options[:spec_dir] || 'spec'
        create_directory
        generate_pact_helper
      end

      def create_directory
        FileUtils.mkdir_p(provider_dir)
      end

      def provider_dir
        File.join(@spec_dir, 'service_providers')
      end

      def generate_pact_helper
        template_string = File.read(File.expand_path( '../templates/consumer/pact_helper.erb', __FILE__))
        render = ERB.new(template_string).result(binding)
        File.open(provider_dir+'/'+'pact_helper.rb', "w+"){ |f| f.write(render) }
      end

      def parse_options(options)
        options[:consumer] ||= 'My Consumer' unless options.has_key? :consumer
        options[:provider] ||= 'My Provider' unless options.has_key? :provider
        options
      end

      def consumer_name
        @options[:consumer].strip
      end

      def provider_name
        @options[:provider].strip
      end

      def provider_to_symb
        provider_name.downcase.gsub(' ', '_')
      end
    end
  end
end
