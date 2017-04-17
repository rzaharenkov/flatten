require_relative '../lib/flatten'
require_relative 'environment'
require 'memory_profiler'

# Analyzes memory used by algorithms. It uses `memory_profiler` gem in order to analyze how much memory has been
# allocated and retained (see https://github.com/SamSaffron/memory_profiler for more details).
class MemoryBenchmark
  LABEL_WIDTH = 40
  METRIC_WITDH = 20
  MEMORY_ALLOCATED = 'Memory allocated'.freeze
  MEMORY_RETAINED = 'Memory retained'.freeze

  MEMORY_UNITS = {
    'B'  => 1024,
    'KB' => 1024 * 1024,
    'MB' => 1024 * 1024 * 1024,
    'GB' => 1024 * 1024 * 1024 * 1024,
    'TB' => 1024 * 1024 * 1024 * 1024 * 1024
  }.freeze

  include TestData

  # Creates an instance of MemoryBenchmark class.
  #
  # Params:
  #
  # data_size - amount of elements in test data array (array is randomly nested).
  def initialize(data_size)
    @data_size = data_size
    @test_set = random_data_set(data_size)
  end

  # Runs the benchmark and prints report to STDOUT.
  def run
    print_header
    Algorithms.list.each do |algorithm|
      run_with_memory_report(algorithm.label) { algorithm.code.call(@test_set) }
    end
  end

  private

  def parse_numeric_argument(raw_value, default_value)
    value = raw_value.to_i
    value > 0 ? value : default_value
  end

  def print_header
    puts "Memory benchmark (data size: #{@data_size})"
    puts "#{' ' * LABEL_WIDTH} #{MEMORY_ALLOCATED.rjust(METRIC_WITDH)} #{MEMORY_RETAINED.rjust(METRIC_WITDH)}"
  end

  def run_with_memory_report(label, &block)
    report = MemoryProfiler.report(&block)
    memory_allocated = human_memory_size(report.total_allocated_memsize).rjust(METRIC_WITDH)
    memory_retained = human_memory_size(report.total_retained_memsize).rjust(METRIC_WITDH)
    puts "#{label.ljust(LABEL_WIDTH)} #{memory_allocated} #{memory_retained}"
  end

  def human_memory_size(value)
    MEMORY_UNITS.each_pair do |label, limit|
      return "#{(value.to_f / (limit / 1024)).round(2)}#{label}" if value < limit
    end
  end
end
