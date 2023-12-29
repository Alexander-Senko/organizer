# Organizer

A Rails Engine providing some tools to organize your application records, e.g. _lists_, _tags_, _flags_, etc.

## Usage

### `Identifiable`

Presuming `MyModel` has a unique `name` attribute:

```ruby
class MyModel < ApplicationRecord
  include Organizer::Identifiable.by :name
end

MyModel.names     # => [:my_name, :other_name, …]
MyModel[:my_name] # => #<MyModel1 id: 1, name: "my_name">
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "organizer-rails"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install organizer-rails
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
