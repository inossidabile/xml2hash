# Xml2Hash

This is a tiny gem allowing you to parse XML stream (or string) into Ruby hash via available SAX parser. Supported parsers are: (Ox)[https://github.com/ohler55/ox], (Nokogiri)[https://github.com/sparklemotion/nokogiri].

Note that the functionality of this gem is very limited. It completely ignores attributes and namespaces currently and was intended to speed things up when you need to parse simple mid-size XML for basic in-memory manipulation. And you run on Heroku. Inside of Sidekiq :scream:.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xml2hash'
```

Make sure this lines goes afer one of the following:

```ruby
gem 'ox'       # This gem is recommended to lower memory consumption and imrove speed
gem 'nokogiri' # Fallback when Ox isn't available (e.g. you are using JRuby)

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xml2hash

## Usage

```ruby
hash = Xml2Hash.parse('<xml></xml>')
hash = Xml2Hash.parse(File.open 'file.xml', 'r')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/inossidabile/xml2hash.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

