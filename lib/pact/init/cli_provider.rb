require 'thor'
require 'pact/init'

module Pact
  module Init
    class CLIProvider < Thor

      desc 'create' , "Initalize your spec dir with the pact helper file"
      method_option :consumer, aliases: "--consumer", :desc => "The name of your consumer"
      method_option :provider, aliases: "--provider", :desc => "The name of your provider"

      def create(args = {})
        args[:consumer] = options['consumer'] if options['consumer']
        args[:provider] = options['provider'] if options['provider']
        Pact::Init::Provider.call(args)
        puts 'Congratulations, you are now ready to pact!'
      end

      default_task :create
    end
  end
end
