# frozen_string_literal: true
require 'test_helper'

module ChainEnumTests
  def doit(yielder, i)
    yielder << i**2
  end

  def test_it_works
    assert_equal [16, 25, 36], @enum.first(3)
  end
end

class EnumerableTest < Minitest::Test
  include ChainEnumTests

  def setup
    @enum = (4..10).chain(&method(:doit))
  end
end

class EnumeratorTest < Minitest::Test
  include ChainEnumTests

  def setup
    @enum = (4..10).to_enum { 7 }.chain(&method(:doit))
  end
end

class LazyEnumeratorTest < Minitest::Test
  include ChainEnumTests

  def setup
    @enum = (4..Float::INFINITY).lazy.chain(&method(:doit))
  end
end if Enumerator.const_defined?(:Lazy)
