require 'sinatra'
require 'slim'
require 'data_mapper'
require 'rack-flash'
require './models/user'

class HelloWorldApp < Sinatra::Base
  enable :sessions
  use Rack::Flash, :accessorize => [:info, :error, :success, :notice], :sweep => true

  get '/' do
    @users = User.all
    slim :index
  end

  post '/users/create' do
    @user = User.new params

    if @user.save 
      flash[:success] = "Congratulations, #{@user.username}!"
    else
      flash[:error] = @user.errors.full_messages
    end

    redirect to('/')
  end
end

configure :development do
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
  DataMapper.finalize
  DataMapper.auto_upgrade!
end
