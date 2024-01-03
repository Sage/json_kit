# JsonKit

[![Build Status](https://travis-ci.org/Sage/json_kit.svg?branch=master)](https://travis-ci.org/Sage/json_kit)
[![Maintainability](https://api.codeclimate.com/v1/badges/aceb2a238169f80ca614/maintainability)](https://codeclimate.com/github/Sage/json_kit/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/aceb2a238169f80ca614/test_coverage)](https://codeclimate.com/github/Sage/json_kit/test_coverage)
[![Gem Version](https://badge.fury.io/rb/json_kit.svg)](https://badge.fury.io/rb/json_kit)

Welcome to your JsonKit! JsonKit is a toolkit for working with json.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_kit'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install json_kit
```

## Usage


#JsonKit::Helper

This is class contains helper methods for working with json.

## #to_json

This method is called to convert an object to a json string. (This can be a class instance or hash)

```ruby
json = helper.to_json(obj)
```

## #from_json

This method is called to convert a json string to an ruby object.

```ruby
hash = helper.from_json(json)

  ....

#json_kit uses hash_kit so supports specifying a class name and transforms to convert the json into a ruby class instance.
obj = helper.from_json(json, TestEntity, transforms)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sage/json_kit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

This gem is available as open source under the terms of the
[MIT licence](LICENSE).

Copyright (c) 2018 Sage Group Plc. All rights reserved.
