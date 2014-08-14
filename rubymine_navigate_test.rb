#!/usr/bin/env ruby
#http://pivotallabs.com/swapping-javascript-spec-implementation-rubymine/

require 'fileutils'

file = ARGV[0] || raise
basename = File.basename(file)

basename_to_open = if file.include?('spec')
  basename.sub /_spec\.(coffee|rb)/, '.\1'
else
  basename.sub /\.(\w+)$/, '_spec.\1'
end

existing_file = Dir['**/*'].find do |f|
  File.basename(f) == basename_to_open
end

if existing_file
  system '/usr/local/bin/mine', existing_file
else
  if file.include?('spec')
    file_path_to_create = file.sub(/_spec/, '').sub(/^spec\//, 'app/')
  else
    file_path_to_create = file.sub(/\.(\w+)$/, '_spec.\1').sub(/^app\//, 'spec/')
  end

  FileUtils.touch file_path_to_create
  system '/usr/local/bin/mine', file_path_to_create
end