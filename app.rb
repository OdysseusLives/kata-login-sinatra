require 'sinatra'
require 'slim'

class HelloWorldApp < Sinatra::Base
    get '/' do
      slim :index
    end
end
