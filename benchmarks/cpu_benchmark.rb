require_relative '../lib/flatten'
require_relative 'environment'
require 'benchmark'

# Measures and reports time consumed by algorithms with ruby standard `Benchmark` module.
class CpuBenchmark
  LABEL_WIDTH = 40

  include TestData

  # Creates an instance of CpuBenchmark class.
  #
  # Params:
  #
  # data_size  - amount of elements in test data array (array is randomly nested).
  # iterations - number of test iterations.
  def initialize(data_size, iterations)
    @data_size = data_size
    @iterations = iterations
    @test_set = random_data_set(data_size)
  end

  # Runs the benchmark and prints report to STDOUT.
  def run
    puts "CPU benchmark (data size: #{@data_size}, iterations: #{@iterations})"
    Benchmark.bm(LABEL_WIDTH) do |b|
      Algorithms.list.each do |algorithm|
        b.report(algorithm.label) do
          @iterations.times { |i| algorithm.code.call(@test_set) }
        end
      end
    end
  end

  private

  def parse_numeric_argument(raw_value, default_value)
    value = raw_value.to_i
    value > 0 ? value : default_value
  end
end
