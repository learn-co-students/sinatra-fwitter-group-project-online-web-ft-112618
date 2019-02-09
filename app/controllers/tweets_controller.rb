class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/users/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/users/login'
    end
  end

  post '/tweets/new' do
    if is_logged_in?(session) && params[:content] != ""
      #binding.pry
      @tweet = Tweet.new(:content => params[:content], :user_id => session[:user_id])
      @tweet.save
      redirect '/tweets'
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find(params[:id])
      erb :'tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
      @tweet = Tweet.find(params[:id])
      @tweet.update(:content => params[:content])
  end

  delete '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
      if @tweet.user_id == current_user(session).id && is_logged_in?(session)
        @tweet.delete
        redirect '/tweets'
      else
        redirect '/tweets'
      end
    end
end
