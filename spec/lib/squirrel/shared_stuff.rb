RSpec.shared_context "shared stuff", :shared_context => :metadata do
  let(:options) { { namespace: "app_v1", compress: true } }
  let(:dalli_client) { Dalli::Client.new("localhost:11211", options) }
  let(:filename) { File.expand_path("test.pdf", File.dirname(__FILE__)) }
  let(:basename) { File.basename(filename) }
  let(:fake_file) { "fake.qw" }

  after(:each) { dalli_client.delete(basename) }
end

RSpec.configure do |rspec|
  rspec.include_context "shared stuff", :include_shared => true
end
