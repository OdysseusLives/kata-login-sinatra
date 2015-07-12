require 'data_mapper'
require 'factory_girl'

Dir[File.dirname(__FILE__)+"/../models/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/test.db")
DataMapper.finalize
DataMapper.auto_upgrade!
