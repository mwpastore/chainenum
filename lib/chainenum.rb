# frozen_string_literal: true
class Enumerator
  def chain(*args)
    self.class.new(*args) do |yielder|
      each do |elem|
        yield yielder, elem
      end
    end
  end

  class Lazy
    def chain(*args, &block)
      self.class.new(self, *args, &block)
    end
  end if const_defined?(:Lazy)
end

module Enumerable
  def chain(*args, &block)
    each.chain(*args, &block).to_a
  end
end
