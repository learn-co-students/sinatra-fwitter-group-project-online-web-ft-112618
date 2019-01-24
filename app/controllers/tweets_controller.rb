class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect :'users/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect :'/users/login'
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content], user_id: current_user.id)
    if tweet.save
      redirect :'/tweets'
    else
      redirect :'/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find_by_id(params[:id])
      @tweet = tweet if tweet
      erb :'tweets/show'
    else
      redirect :login
    end
  end

  get '/tweets/:id/edit' do
    tweet = Tweet.find_by_id(params[:id])
    if logged_in? && tweet && current_user.tweets.include?(tweet)
      @tweet = tweet
      erb :'tweets/edit'
    elsif logged_in?
      redirect :'/tweets'
    else
      redirect :'/login'
    end
  end

  patch '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.update(content: params[:content])
      redirect :"/tweets/#{tweet.id}"
    else
      redirect :"/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:id])
    tweet.destroy if logged_in? && tweet && current_user.tweets.include?(tweet)
    redirect :'/tweets'
  end
end
