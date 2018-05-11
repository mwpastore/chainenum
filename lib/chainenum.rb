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
  def chain(size=nil, &block)
    each.chain(size, &block).to_a
  end
end
