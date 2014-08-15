require 'rspec'
require 'fakefs/spec_helpers'
require_relative './rubymine_navigate_test'

describe 'toggle' do
  include FakeFS::SpecHelpers
  MINE = '/usr/local/bin/mine'

  before do
    FileUtils.mkdir_p %w(app/controller spec/controller)
    expect(all_files).to be_empty
  end

  it 'opens an existing spec' do
    FileUtils.touch 'spec/controller/my_controller_spec.rb'
    expect(Kernel).to receive(:system).with MINE, 'spec/controller/my_controller_spec.rb'
    toggle 'app/controller/my_controller.rb'
    expect(all_files).to eq ['/spec/controller/my_controller_spec.rb']
  end

  it 'creates and opens a spec' do
    expect(Kernel).to receive(:system).with MINE, 'spec/controller/my_controller_spec.rb'
    toggle 'app/controller/my_controller.rb'
    expect(all_files).to eq ['/spec/controller/my_controller_spec.rb']
  end

  it 'opens an existing impl' do
    FileUtils.touch 'app/controller/my_controller.rb'
    expect(Kernel).to receive(:system).with MINE, 'app/controller/my_controller.rb'
    toggle 'spec/controller/my_controller_spec.rb'
    expect(all_files).to eq ['/app/controller/my_controller.rb']
  end

  it 'creates and opens an impl' do
    expect(Kernel).to receive(:system).with MINE, 'app/controller/my_controller.rb'
    toggle 'spec/controller/my_controller_spec.rb'
    expect(all_files).to eq ['/app/controller/my_controller.rb']
  end

  def all_files
    Dir['**/*'].select { |f| File.file?(f) }
  end
end