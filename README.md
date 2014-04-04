# megalopolis-ruby

[![Build Status](https://secure.travis-ci.org/oame/megalopolis-ruby.png)](http://travis-ci.org/oame/megalopolis-ruby)

Megalopolis API wrapper for Ruby.

## Requirement

* Ruby 1.9.3 or higher

## Installation

Add this line to your application's Gemfile:

    gem 'megalopolis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install megalopolis

## Usage

	#!/usr/bin/env ruby
	# coding: utf-8

	require "megalopolis"

	m = Megalopolis.new("http://megalopolis-provider.com")
	subject = m.get :log => 150
	puts subject.first.title

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
