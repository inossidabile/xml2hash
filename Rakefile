require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

UNITS = %W(B KiB MiB GiB TiB).freeze

def as_size(number)
  if number.to_i < 1024
    exponent = 0

  else
    max_exp  = UNITS.size - 1

    exponent = ( Math.log( number ) / Math.log( 1024 ) ).to_i # convert to base
    exponent = max_exp if exponent > max_exp # we need this to avoid overflow for the highest unit

    number  /= 1024 ** exponent
  end

  "#{number} #{UNITS[ exponent ]}"
end

task :default => :spec

task :memory do
  require 'memory_profiler'
  require 'nokogiri'
  require 'ox'
  require 'xml2json'
  require 'xml2hash'

  path = File.dirname(__FILE__) + '/sample.xml'
  data = File.read(path)

  puts 'Xml2Hash (Ox): ' + as_size(MemoryProfiler.report{ Xml2Hash.parse(File.open(path, 'r'), :ox) }.total_allocated_memsize)
  puts 'Xml2Hash (Nokogiri): ' + as_size(MemoryProfiler.report{ Xml2Hash.parse(File.open(path, 'r'), :nokogiri) }.total_allocated_memsize)
  puts 'XML2JSON: ' + as_size(MemoryProfiler.report{ XML2JSON.parse_to_hash data }.total_allocated_memsize)
end