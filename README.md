
# pact-init

This gem will help write skeleton code to get you kick started with writing pact tests for both consumers and providers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pact-init'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pact-init

## Usage
Consumer  
`$ pact-init-consumer`

Will produce a directory in the directory you executed it in equal to ```spec/service_providers/```  
and a file called ```pact_helper.rb``` with the following code.  
``` ruby
require 'pact/consumer/rspec'

Pact.service_consumer 'My Consumer' do
  has_pact_with 'My Provider' do
    mock_service :my_provider do
      port 1234
    end
  end
end
```

You can use either or both of the two optional parameters to customise the names of the consumer and provider. eg..  
`$ pact-init-consumer --consumer "Foo Consumer" --provider "Bar Provider" `  

Provider

```$ pact-init-provider```  
Will produce a directory in the directory you executed it in equal to ```spec/service_consumers/```  and a file called ```pact_helper.rb``` with code  
``` ruby
require 'pact/provider/rspec'
require "service_consumers/provider_states_for_my_consumer"

Pact.service_provider 'My Provider' do
  honours_pact_with 'My Consumer' do
    pact_uri ''
  end
end
```
and another file called ```provider_states_for_my_consumer.rb``` with code  
``` ruby
Pact.provider_states_for 'My Consumer' do
  provider_state 'there is a thing' do
    set_up do
      # Set up the provider state here (eg. insert record into a database)
    end
  end
end
```
You can use either or both of the two optional parameters to customise the names of the consumer and provider. eg..
``$ pact-init-provider --consumer "Foo Consumer" --provider "Bar Provider"``

## Contributing

1. Fork it ( https://github.com/realestate-com-au/pact-init/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
