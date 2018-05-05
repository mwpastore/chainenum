# ChainEnum

Chainable Enumerables, Enumerators, and Lazy Enumerators.

Do you ever find yourself doing something like:

```ruby
even_keys = tuples.select { |_, v| v.even? }.keys.map(&:upcase)
```

Or:

```ruby
even_keys = tuples.map { |k, v| k.upcase if v.even? }.compact
```

I've always found this pattern a little bit off-putting, especially when I have
a big `do`..`end` block containing conditional logic and then a `.compact`
tacked on to it. Maybe I'm picky. You can wrap the logic in an `Enumerator.new
{ |yielder| .. }` or move the logic to a method that returns an enumerator, but
that can be a lot of boilerplate for a simple filter+map operation.

This simple gem monkeypatches Enumerable, Enumerator, and Enumerator::Lazy to
add a `#chain` method that lets you do kind of an inline enumerator. The above
example can be rewritten like this:

```ruby
even_keys = tuples.chain { |yielder, (k, v)| yielder << k.upcase if v.even? }
```

I find this easier to read and grok. Perhaps you will too.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chainenum'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install chainenum
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/mwpastore/chainenum.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
