require './config/environment'
require_relative '../helpers/helpers.rb'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :'application/index'
  end

  get "/signup" do
    if session[:id]
      redirect to "/tweets"
    end
    erb :'application/signup'
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:id] = @user.id
      redirect to "/tweets"
    end
  end

  get "/login" do
    if session[:id]
      redirect to "/tweets"
    end
    erb :'application/login'
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect to "/login"
  end

end
