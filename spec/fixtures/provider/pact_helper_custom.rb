require 'pact/provider/rspec'
Dir.glob("tmp/specz/service_consumers/provider_states_for*.rb") { |file| require file }

Pact.service_provider 'Bar Provider' do
  honours_pact_with 'Foo Consumer' do
    pact_uri ''
  end
end
