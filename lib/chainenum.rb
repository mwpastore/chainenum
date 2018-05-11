# frozen_string_literal: true
class Enumerator
  def chain(size=nil)
    self.class.new(size) do |yielder|
      each do |elem|
        yield yielder, elem
      end
    end
  end

  class Lazy
    def chain(size=nil, &block)
      self.class.new(self, size, &block)
    end
  end if const_defined?(:Lazy)
end

module Enumerable
  def chain(size=0)
    memo, index = Array.new(size), 0
    # we need an object that responds to both #<< and #yield
    yielder = Enumerator::Yielder.new do |head, *tail|
      memo[index], index = (tail.empty? ? head : tail.unshift(head)), index.succ
    end

    each do |elem|
      yield yielder, elem
    end

    # trim array if we preallocated more space than necessary
    memo.slice!(index.succ .. -1) if memo.size > index.succ

    memo
  end
end
