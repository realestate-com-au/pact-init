require 'erb'

module Pact
  module Init
    class Provider

      def self.call(options = {})
        new.call(options)
      end

      def call(options)
        @consumer_name = (options[:consumer] || 'My Consumer').strip
        @provider_name = (options[:provider] || 'My Provider').strip
        @spec_dir      = (options[:spec_dir] || 'spec')
        create_directory
        generate_pact_helper
        generate_provider_states
      end

      private

      attr_reader :consumer_name, :provider_name, :spec_dir

      def create_directory
        FileUtils.mkdir_p(consumer_dir)
      end

      def consumer_dir
        File.join(spec_dir, 'service_consumers')
      end

      def pact_helper_path
        File.join(consumer_dir, 'pact_helper.rb')
      end

      def provider_states_path
        File.join(consumer_dir, "provider_states_for_#{consumer_name_to_snakecase}.rb")
      end

      def generate_pact_helper
        create_file_from_template(
          File.expand_path('../templates/provider/pact_helper.erb', __FILE__),
          pact_helper_path)
      end

      def generate_provider_states
        create_file_from_template(
          File.expand_path('../templates/provider/provider_states_for_my_consumer.erb', __FILE__),
          provider_states_path)
      end

      def create_file_from_template template_path, file_path
        template_string = File.read(template_path)
        render = ERB.new(template_string).result(binding)
        File.open(file_path, "w"){ |f| f.write(render) }
      end

      def consumer_name_to_snakecase
        consumer_name.downcase.gsub(' ', '_')
      end
    end
  end
end
