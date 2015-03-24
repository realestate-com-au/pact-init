
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

Will produce a directory's in the directory you executed it in ```spec/service_providers/```  
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
`$ pact-init --consumer "Foo Consumer" --provider "Bar Provider" `  

TODO  
```$ pact-init-provider```

## Contributing

1. Fork it ( https://github.com/realestate-com-au/pact-init/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
