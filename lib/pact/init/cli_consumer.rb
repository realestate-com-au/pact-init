require 'thor'
require 'pact/init'

module Pact
  module Init
    class CLIConsumer < Thor

      desc 'create' , "Initalize your spec dir with the pact helper file"
      method_option :consumer, aliases: "--consumer", :desc => "The name of your consumer"
      method_option :provider, aliases: "--provider", :desc => "The name of your provider"

      def create(args = {})
        if options['consumer']
          args[:consumer] = options['consumer']
        end
        if options['provider']
          args[:provider] = options['provider']
        end
        Pact::Init::Consumer.call(args)
        puts 'Congratulations, you are now ready to pact!'
      end
      default_task :create
    end
  end
end
