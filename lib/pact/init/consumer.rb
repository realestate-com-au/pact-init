
module Pact
  module Init
    class Consumer

      def self.run
        new.run
      end

      def run
        create_directory
        create_files
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

    end
  end
end
