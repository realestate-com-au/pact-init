require 'pact/consumer/rspec'

Pact.service_consumer 'My Consumer' do
  has_pact_with 'Bar Provider' do
    mock_service :bar_provider do
      port 1234
    end
  end
end
