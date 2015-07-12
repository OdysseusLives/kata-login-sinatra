require 'data_mapper'
require 'factory_girl'
require 'database_cleaner'

Dir[File.dirname(__FILE__)+"/../models/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

	config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each, :database) do
    DatabaseCleaner.start
  end

  config.after(:each, :database) do
    DatabaseCleaner.clean
  end
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/test.db")
DataMapper.finalize
DataMapper.auto_upgrade!
