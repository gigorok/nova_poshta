# NovaPoshta

[![Gem Version](https://badge.fury.io/rb/nova_poshta.svg)](https://badge.fury.io/rb/nova_poshta)
[![Build Status](https://travis-ci.org/gigorok/nova_poshta.svg?branch=master)](https://travis-ci.org/gigorok/nova_poshta)

Ruby-client to novaposhta.ua API2.

Look at API documentation by link https://my.novaposhta.ua/data/instruction_JSON_ver.1.7.pdf

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nova_poshta'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nova_poshta

## Configuration

By default the application gets API KEY from ENV['NOVA_POSHTA_API_KEY'].
But you can set it directly by next code:
```ruby
NovaPoshta.configure do |config|
    config.api_key = 'YOUR_API_KEY'
end
```

## Usage
```ruby
a = NovaPoshta::Model::Address.new # an instance of address model
area = a.areas.to_a.sample # to get a some area
area.cities # to get all cities
city = a.cities(find_by_string: '[city name]').to_a.sample # you can filter by city name
city.area # get the area from a city instance
warehouse = city.warehouses(find_by_string: '[warehouse address]').to_a.sample
a.warehouses(city.ref)
a.areas
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gigorok/nova_poshta. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

