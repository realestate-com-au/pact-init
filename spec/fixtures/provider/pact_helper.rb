require 'pact/provider/rspec'
require 'service_consumers/provider_states_for_my_consumer'

Pact.service_provider 'My Provider' do
  honours_pact_with 'My Consumer' do
    pact_uri ''
  end
end