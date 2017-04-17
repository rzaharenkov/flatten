module Algorithms
  Algorithm = Struct.new(:label, :code)

  class << self
    def list
      @list ||= []
    end

    def register(label, code)
      list << Algorithm.new(label, code)
    end
  end

  register 'Array.flatten', ->(array) { array.flatten }
  register 'Flatten.flatten', ->(array) { Flatten.flatten(array) }
  register 'Flatten.reccursive_flatten', ->(array) { Flatten.reccursive_flatten(array) }
end
