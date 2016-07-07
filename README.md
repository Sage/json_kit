# JsonKit

Welcome to your JsonKit! JsonKit is a toolkit for working with json.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_kit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_kit

## Usage


#JsonKit::Helper

This is class contains helper methods for working with json.

## #to_json

This method is called to convert an object to a json string. (This can be a class instance or hash)

    json = helper.to_json(obj)

## #from_json

This method is called to convert a json string to an ruby object.

    hash = helper.from_json(json)

....

    #json_kit uses hash_kit so supports specifying a class name and transforms to convert the json into a ruby class instance.
    obj = helper.from_json(json, TestEntity, transforms)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vaughanbrittonsage/hash_kit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

