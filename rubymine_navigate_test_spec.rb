require 'rspec'
require 'fakefs/spec_helpers'

describe 'rubymine_navigate_test' do
  include FakeFS::SpecHelpers

  def all_files
    Dir['**/*'].select { |f| File.file?(f) }
  end

  before do
    FileUtils.mkdir_p %w(app/controller spec/controller)
    expect(all_files).to be_empty
  end

  it 'runs' do
    FileUtils.touch 'spec/controller/application_controller_spec.rb'
    stub_const 'ARGV', ['app/controller/application_controller.rb']
    expect(Kernel).to receive(:system).with '/usr/local/bin/mine', '/spec/controller/application_controller_spec.rb'
    expect(all_files).to eq ['/spec/controller/application_controller_spec.rb']
    load './rubymine_navigate_test.rb'
  end
end