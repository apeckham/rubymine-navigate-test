require 'rspec'
require 'fakefs/spec_helpers'
require_relative './rubymine_navigate_test'

describe 'toggle' do
  include FakeFS::SpecHelpers

  def all_files
    Dir['**/*'].select { |f| File.file?(f) }
  end

  before do
    FileUtils.mkdir_p %w(app/controller spec/controller)
    expect(all_files).to be_empty
  end

  it 'opens an existing spec' do
    FileUtils.touch 'spec/controller/application_controller_spec.rb'
    stub_const 'ARGV', ['app/controller/application_controller.rb']
    expect(Kernel).to receive(:system).with '/usr/local/bin/mine', '/spec/controller/application_controller_spec.rb'
    toggle
    expect(all_files).to eq ['/spec/controller/application_controller_spec.rb']
  end

  it 'creates and opens a spec' do
    stub_const 'ARGV', ['app/controller/application_controller.rb']
    expect(Kernel).to receive(:system).with '/usr/local/bin/mine', 'spec/controller/application_controller_spec.rb'
    toggle
    expect(all_files).to eq ['/spec/controller/application_controller_spec.rb']
  end

  it 'opens an existing impl' do
    FileUtils.touch 'app/controller/application_controller.rb'
    stub_const 'ARGV', ['spec/controller/application_controller_spec.rb']
    expect(Kernel).to receive(:system).with '/usr/local/bin/mine', '/app/controller/application_controller.rb'
    toggle
    expect(all_files).to eq ['/app/controller/application_controller.rb']
  end
end