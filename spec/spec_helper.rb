require "bundler/setup"
require "factory_bot"
require "faker"
require "xrechnung"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

def to_xml(entity)
  entity.to_xml(Builder::XmlMarkup.new(indent: 2))
end

def expect_xml_eq_fixture(entity, fixture_base_name)
  expect(to_xml(entity)).to eq File.read("spec/fixtures/scraps/#{fixture_base_name}.xml")
end
