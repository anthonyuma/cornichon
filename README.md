# Cornichon

A cornichon is a fancy gherkin ([WIKI](https://en.wikipedia.org/wiki/Pickled_cucumber#Cornichon))

Cornichon allows you to write pseudo-Gherkin features that will transpile to valid Gherkin. In the process, you can programatically insert content into those features before running your cucumber tests. Now, your can write your acceptance tests to be more configurable, flexible, reusable, dynamic and greatly increase your test coverage!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cornichon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cornichon

## Usage

By default, Cornichon expects the following directory structure for your project:

```
project_root/
  ...
  - features/
    - cornichon/
      - templates/
        - a_feature.cornichon
        - and_another.cornichon
        ...
      - presenters/
        - presenters_methods_here.rb
        ...
  ...
```

On transpilation, your features will by default be written to `features/cornichon/features`. (You should ideally ignore this directory in version control).

(TODO: Configuration of features/presenter/template paths)

Here's how it works:

This:
```feature
# features/cornichon/templates/joke.cornichon

Scenario: A classic pub joke
  Given A {{person}} walks into a bar
  Then expect consequences
```
With this:
```rb
# features/cornichon/presenters/joke.rb

def person
  ['Englishman', 'Irishman', 'Scotsman', 'Welshman'].sample
end
```
Gives you this:
```joke.feature
# features/cornichon/features/joke.feature

Scenario: A classic pub joke
  Given A Scotsman walks into a bar
  Then expect consequences
```

Your Cornichon templates (use the extension `.cornichon`) are meant to be an extension of Gherkin, so there's nothing stopping you writing them in plain Gherkin, and they will be copied verbatim into your cornichon features directory.

e.g.
```feature
# features/cornichon/templates/foo.cornichon

Feature: A plain Gherkin feature

Scenario: A plain Gherkin scenario
  Given something is the case
  When something else happends
  Then expect consequences

```

... transpiles to ...

```feature
# features/cornichon/features/foo.feature

Feature: A plain Gherkin feature

Scenario: A plain Gherkin scenario
  Given something is the case
  When something else happends
  Then expect consequences

```

You can inject values into your

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

