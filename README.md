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

## Quick Start

Add the following files to your project
```
your_project/
  features/
    cornichon/
      templates/
        quick_start.cornichon
      presenters/
        quick_start.rb
```

```feature
# features/cornichon/templates/quick_start.cornichon

Feature: A very quick start

Scenario: You're never gonna keep me down
  Given I've been knocked down {{several}} times
  Then I get up again
```

```rb
# features/cornichon/presenters/quick_start.rb

def several
  # return a random number between 2 .. 100
  2 + rand(99)
end
```

Then simply run
```sh
bundle exec cornichon
```

And voilà! you should have a brand new feature file in `features/cornichon/features`.
Now run your cucumber tests!

## Usage

## Simple values

use `{{double braces}}` to insert a method value

Template:
```feature
# features/cornichon/templates/joke.cornichon

Scenario: A classic pub joke
  Given A {{person}} walks into a bar
  Then expect consequences
```
Presenter:
```rb
# features/cornichon/presenters/joke.rb

def person
  ['Englishman', 'Irishman', 'Scotsman', 'Welshman'].sample
end
```
Sample Output:
```feature
# features/cornichon/features/joke.feature

Scenario: A classic pub joke
  Given A Scotsman walks into a bar
  Then expect consequences
```

### Nested values

use `{{dot.separated.keys}}` to specify values within a nested hash

### Tables

use `[[double square brackets]]` to insert a table from an array of hashes (or a single hash for a single row table)

Template:
```feature
# features/cornichon/templates/nursery_rhyme.cornichon

Scenario Outline: A classic nursery rhyme
  Given I was born on a "<day>"
  Then I should "<expectation>"
  Examples:
  [[mondays_child]]
  
```
Presenter:
```rb
# features/cornichon/presenters/nursery_rhyme.rb

def mondays_child
  [
    {
      'day' => 'Monday'
      'expectation' => 'be fair of face'
    },
    {
      'day' => 'Tuesday'
      'expectation' => 'be full of grace'
    },
    {
      'day' => 'Wednesday'
      'expectation' => 'be full of woe'
    },
    {
      'day' => 'Thursday'
      'expectation' => 'have far to go'
    },
    {
      'day' => 'Friday'
      'expectation' => 'be loving and giving'
    },
    {
      'day' => 'Saturday'
      'expectation' => 'work hard for a living'
    },
    {
      'day' => 'Sunday'
      'expectation' => 'be bonnie and blithe and good and gay'
    }
  ]
end
```
Sample Output:
```feature
# features/cornichon/features/nursery_rhyme.feature

Scenario Outline: A classic nursery rhyme
  Given I was born on a "<day>"
  Then I should "<expectation>"
  Examples:
  | day       | expectation                           |
  | Monday    | be fair of face                       |
  | Tuesday   | be full of grace                      |
  | Wednesday | be full of woe                        |
  | Thursday  | have far to go                        |
  | Friday    | be loving and giving                  |
  | Saturday  | work hard for a living                |
  | Sunday    | be bonnie and blithe and good and gay |
```

### The + sign

use `{{+a plus sign}}` to refer to the last instance of a key (rather than calling the method again)
You may need to use this if your methods do not return the same value on every call

Template:
```feature
# features/cornichon/templates/reply.cornichon

Scenario: Being polite
  Given my name is {{name}}
  When someone asks me my name
  Then I would say 'My name is {{+name}}'
```
Presenter:
```rb
# features/cornichon/presenters/reply.rb

def name
  ['Sarah', 'Thomas', 'Michael', 'Jane', 'Fred', 'Kirsty'].sample
end
```
Sample Output:
```feature
# features/cornichon/features/joke.feature

Scenario: Being polite
  Given my name is Jane
  When someone asks me my name
  Then I would say 'My name is Jane'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

