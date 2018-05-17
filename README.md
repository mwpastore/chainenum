# Piecewise Rubygem

Piecewise Enumerables, Enumerators, and Lazy Enumerators for Ruby.

### Synopsis

Do you ever find yourself doing something like:

```ruby
even_keys = tuples.map { |k, v| k.upcase if v.even? }.compact

# Or:

even_keys = tuples.select { |_, v| v.even? }.keys.map(&:upcase)

# Or:

even_keys = tuples.each_with_object([]) do |(k, v), memo|
  memo << k.upcase if v.even?
end
```

**Now consider the case when `tuples` is infinitely large and you want to yield
even keys, capitalized, to a downstream consumer.**

I've always found this pattern (and its alternatives) a little bit off-putting,
especially when you have a big `do`..`end` block containing conditional logic
and then a `.compact` tacked on to it. (Maybe I'm picky.) And sometimes `nil`
is a valid value, so you have to introduce a new sentinel value to reject by.
You can wrap the logic in an `Enumerator.new { |yielder| .. }` or move the
logic to a method that returns an enumerator, but that can be a lot of
boilerplate for what should be a simple filter+map operation.

This simple gem monkeypatches Enumerable, Enumerator, and Enumerator::Lazy to
add a `#piecewise` method that lets you do kind of an inline enumerator. The
above example can be rewritten like this:

```ruby
even_keys = tuples.piecewise { |yielder, (k, v)| yielder << k.upcase if v.even? }
```

I find this easier to read and grok, and it works the same whether `tuples` is
a simple enumerable or a (lazy) enumerator.

### Concept

This gem implements an [inversion of control][1] pattern in which the
underlying Enumerator::Yielder object of the [Enumerator][2] is yielded back to
the caller to make use of directly. This makes it easy to perform
[piecewise][3] filter and/or map operations over an enumerable collection. It
is particularly useful when not all of the elements on the input are guaranteed
to be present on the output (otherwise a simple `#map` would do) *and* when
some of the elements may be mutated by the filter (otherwise a simple `#select`
would do). The confluence of these two requirements can lead to inelegant Ruby
code.

You can think of `#piecewise` like Enumerable#each_with_object and
Enumerator#with_object with the following key differences:

* The order of block arguments is reversed
* The "memo" is *always* an Enumerator::Yielder (not an arbitrary object)
* When the receiver is an Enumerator, the result is an Enumerator (not an
  array)
* When the receiver is an Enumerator::Lazy, the result is an Enumerator::Lazy
  (not an array)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'piecewise'
```

And then execute:

```sh
$ bundle
```

Or install it yourself like so:

```sh
$ gem install piecewise
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

This gem was briefly named **chainenum** before being renamed to **piecewise**.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/mwpastore/ruby-piecewise.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

[1]: https://en.wikipedia.org/wiki/Inversion_of_control
[2]: https://ruby-doc.org/core-2.5.1/Enumerator.html
[3]: https://en.wikipedia.org/wiki/Piecewise
