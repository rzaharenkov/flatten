module Flatten
  class << self
    # Returns a new array that is a one-dimensional flattening of given array.
    # Raises ArgumentError if given argument is not an array.
    #
    # NOTE: this implementation uses stack and should consume less resources
    #       but at the same time it more difficult to read and understand this code.
    def flatten(array)
      ensure_array!(array)

      stack = []
      result = []
      buffer = array

      while true
        if buffer.is_a?(Array)
          stack.concat(buffer.reverse)
        else
          result << buffer
        end

        buffer = stack.pop
        break unless buffer
      end

      result
    end

    # Returns a new array that is a one-dimensional flattening of given array.
    # Raises ArgumentError if given argument is not an array.
    #
    # NOTE: this implementation is written in functional style, it's pretty clear and straightforward
    #       but at the same time it consumes more memory and CPU time.
    def reccursive_flatten(array)
      ensure_array!(array)
      recursive_flatten_internal(array)
    end

    private

    def ensure_array!(value)
      raise ArgumentError.new('An instance of Array should be passed') unless value.is_a?(Array)
    end

    def recursive_flatten_internal(array)
      if array.is_a?(Array)
        array.inject([]) do |memo, element|
          memo.concat(recursive_flatten_internal(element))
        end
      else
        [array]
      end
    end
  end
end
