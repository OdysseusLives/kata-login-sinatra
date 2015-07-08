require 'sinatra'
require 'slim'
require 'data_mapper'

class HelloWorldApp < Sinatra::Base
    get '/' do
      @users = User.all
      slim :index
    end

    post '/user' do
      User.create params
      redirect to('/')
    end
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class User
    include DataMapper::Resource
    property :id,           Serial
    property :username,     String, :required => true
    property :password,     String, :required => true
    property :completed_at, DateTime
end
DataMapper.finalize

configure :development do
  DataMapper.finalize
  DataMapper.auto_upgrade!
end
