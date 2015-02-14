require 'thor'
require 'pact/init'

module Pact
  module Init
    class CLI < Thor

      desc 'create' , "run the command line interface"
      method_option :consumer, aliases: "--consumer", :desc => "The name of your consumer"
      method_option :provider, aliases: "--provider", :desc => "The name of your provider"

      def create(args = {})
        if !options['consumer'].nil?
          args[:consumer] = options['consumer']
        end
        if !options['provider'].nil?
          args[:provider] = options['provider']
        end
        Pact::Init::Consumer.run(args)
      end

      default_task :create
    end
  end
end
