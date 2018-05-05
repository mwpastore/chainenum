# frozen_string_literal: true
class Enumerator
  def chain
    self.class.new do |yielder|
      each do |elem|
        yield yielder, elem
      end
    end
  end

  class Lazy
    def chain(&block)
      self.class.new(self, &block)
    end
  end if const_defined?(:Lazy)
end

module Enumerable
  def chain
    each_with_object([]) do |elem, memo|
      yield memo, elem
    end
  end
end
