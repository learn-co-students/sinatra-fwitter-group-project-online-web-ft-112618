class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect :'/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect :'/tweets'
    else
      redirect :'/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.delete(:user_id)
      redirect :'users/login'
    else
      redirect :'/'
    end
  end

  get '/signup' do
    if session[:user_id]
      redirect :'/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    # binding.pry
    if User.find_by(username: params[:user][:username]) || User.find_by(email: params[:user][:email]) || params[:user][:password].empty? || params[:user][:username].empty? || params[:user][:email].empty?
      redirect :'users/signup'
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect :'/tweets'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])

    erb :'users/show'
  end

end
