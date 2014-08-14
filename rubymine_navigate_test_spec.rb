require 'rspec'
require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers, fakefs: true
end

describe 'rubymine_navigate_test' do
  before do
    FakeFS.activate!
    FileUtils.mkdir_p %w(app/controller spec/controller)
  end

  it 'runs' do
    FileUtils.touch 'spec/controller/application_controller_spec.rb'
    stub_const 'ARGV', ['app/controller/application_controller.rb']
    expect(Kernel).to receive(:system).with '/usr/local/bin/mine', '/spec/controller/application_controller_spec.rb'
    expect(File).to exist('spec/controller/application_controller_spec.rb')
    load './rubymine_navigate_test.rb'
  end
end