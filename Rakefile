require 'bundler'
Bundler.require

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: :spec

require_relative 'benchmarks/cpu_benchmark'
require_relative 'benchmarks/memory_benchmark'

namespace :benchmark do
  desc 'Runs CPU benchmark'
  task :cpu, :data_size, :iterations do |t, args|
    data_size = (args[:data_size] || 10_000).to_i
    iterations = (args[:iterations] || 1_000).to_i
    CpuBenchmark.new(data_size, iterations).run
  end

  desc 'Runs memory benchmark'
  task :memory, :data_size do |t, args|
    data_size = (args[:data_size] || 10_000).to_i
    MemoryBenchmark.new(data_size).run
  end
end

desc 'Runs all benchmarks'
task :benchmark, :data_size, :iterations do |t, args|
  Rake::Task['benchmark:memory'].invoke(args[:data_size])
  puts
  puts "=" * 50
  puts
  Rake::Task['benchmark:cpu'].invoke(args[:data_size], args[:iterations])
end
