require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  #include Helpers

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
      
    if @user.class == User 
      session[:user_id] = @user.id 
      erb :account
    else
      erb :error
   end
  end

  get '/account' do
    #binding.pry
    if session[:user_id] != nil && session[:user_id] != ""
     erb :account
    else
     erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

end