require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb ':users/create_user'
  end




# check who is the current user
def current_user
  user = ''
end
# if we don't have an user who logged in
# if nil, direct user to login page
def logged_in?
  !!current_user
end

#if user not loggin in, run this to check if we have this user
# if return nil, direct user to signup page
def user_exist?
end

end
