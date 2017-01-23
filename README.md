# Cccode

Country and Currency Code provides quick access to country and currency data via SOAP webservice provided by http://www.webservicex.net.

The data of all countries can be accessed directly via SOAP or be persisted and used via local database access.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cccode'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cccode
    
After the gem is installed you need to create the country_codes table via the gem`s generator:
    
    $ rails g cccode:install
    $ rake db:migrate

## Usage
Enable usage by adding this to your class/ ruby file:

```ruby
require 'Cccode'
```

### Soap
This section explains how to call the web service via SOAP directly. For quick access via local db see next section 'Database'.

__Get all countries as an array:__

    Cccode.get_countries

__Get country code by country:__

    Cccode.get_country_code(<country name>)
    
__Get currency by country:__

    Cccode.get_currency(<country name>)
    
__Get currency code by currency:__

    Cccode.get_currency_code(<currency name>)

Note: all these actions __DO NOT__ persist the data. To achieve that see 'Database' section!


### Database
To get all available data at once and fill the database (reset is executed upfront):

    Cccode.get_all

__Reset (truncate) conutry_codes table:__
    
    Cccode.reset

__Get all data for a country:__

    data = Cccode::Codes.new(<country name>)
    
__Example: data = Cccode::Codes.new('Germany') returns:__

    data.country       = 'Germany'
    data.country_code  = 'de'
    data.currency      = 'Mark'
    data.currency_code = 'DEM'

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cherrystoned/cccode. 

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

