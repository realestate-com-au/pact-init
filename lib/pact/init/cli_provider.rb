require 'thor'
require 'pact/init'

module Pact
  module Init
    class CLIProvider < Thor

      desc 'create' , "initalize your spec dir with the helper class"
      method_option :consumer, aliases: "--consumer", :desc => "The name of your consumer"
      method_option :provider, aliases: "--provider", :desc => "The name of your provider"

      def create(args = {})
        if options['consumer']
          args[:consumer] = options['consumer']
        end
        if options['provider']
          args[:provider] = options['provider']
        end
        Pact::Init::Provider.call(args)
        puts 'Congratulations, you are now ready to pact!'
      end
      default_task :create
    end
  end
end
