require 'thor'
require 'pact/init'

module Pact
  module Init
    class CLI < Thor
      Pact::Init::Consumer.run
    end
  end
end
