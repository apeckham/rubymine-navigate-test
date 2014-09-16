#!/usr/bin/env ruby
require 'fileutils'

def find_opposite(file)
  if file.include?('spec')
    file.sub(/_spec/, '').sub(/^spec\//, 'app/')
  else
    file.sub(/\.(\w+)$/, '_spec.\1').sub(/^app\//, 'spec/')
  end
end

def toggle(file)
  opposite = find_opposite(file)
  FileUtils.mkdir_p File.dirname(opposite)
  FileUtils.touch opposite
  Kernel.system '/usr/local/bin/mine', opposite
end

toggle(ARGV[0] || raise) if __FILE__ == $0
