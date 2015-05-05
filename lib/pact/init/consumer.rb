require 'erb'

module Pact
  module Init
    class Consumer

      def self.call(options = {})
        new.call(options)
      end

      def call(options)
        @consumer_name = (options[:consumer] || 'My Consumer').strip
        @provider_name = (options[:provider] || 'My Provider').strip
        @spec_dir      = (options[:spec_dir] || 'spec')
        create_directory
        generate_pact_helper
      end

      private

      attr_reader :consumer_name, :provider_name, :spec_dir

      def create_directory
        FileUtils.mkdir_p(provider_dir)
      end

      def provider_dir
        File.join(spec_dir, 'service_providers')
      end

      def pact_helper_path
        File.join(provider_dir, 'pact_helper.rb')
      end

      def generate_pact_helper
        create_file_from_template(
          File.expand_path('../templates/consumer/pact_helper.erb', __FILE__),
          pact_helper_path)
      end

      def create_file_from_template template_path, file_path
        template_string = File.read(template_path)
        render = ERB.new(template_string).result(binding)
        File.open(file_path, "w"){ |f| f.write(render) }
      end

      def provider_to_symb
        provider_name.downcase.gsub(' ', '_')
      end
    end
  end
end
