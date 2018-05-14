# frozen_string_literal: true
class Enumerator
  def piecewise(*args)
    self.class.new(*args) do |yielder|
      each do |*values|
        yield yielder, *values
      end
    end
  end

  class Lazy
    def piecewise(*args, &block)
      self.class.new(self, *args, &block)
    end
  end if const_defined?(:Lazy)
end

module Enumerable
  def piecewise(*args, &block)
    each(*args).piecewise(&block).to_a
  end
end
