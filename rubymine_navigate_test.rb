require 'fileutils'

def toggle(file)
  if file.include?('spec')
    file_to_open = file.sub(/_spec/, '').sub(/^spec\//, 'app/')
  else
    file_to_open = file.sub(/\.(\w+)$/, '_spec.\1').sub(/^app\//, 'spec/')
  end

  FileUtils.mkdir_p File.dirname(file_to_open)
  FileUtils.touch file_to_open
  Kernel.system '/usr/local/bin/mine', file_to_open
end

toggle(ARGV[0] || raise) if __FILE__ == $0