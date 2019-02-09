class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == '' || params[:email] == '' || params[:password] == ''
      redirect '/signup'
    else
      @user = User.new(:username => params[:username],:email => params[:email],:password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if is_logged_in?(session)
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/users/login'
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'user/show'
  end

end
