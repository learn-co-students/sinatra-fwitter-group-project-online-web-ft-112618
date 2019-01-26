class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @tweets = Tweet.all
      @user = User.find_by(id: session[:id])
      erb :"tweet/index"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :"tweet/new"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    @user = Helpers.current_user(session)
    if params[:content] != ""
      @tweet = Tweet.create(content: params[:content], user_id: @user.id )
      redirect to '/tweets'
    else
      redirect to "/tweets/new"
    end
  end

  get "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if Helpers.is_logged_in?(session)
     erb :"tweet/show"
    else
      redirect to "/login"
    end
  end

    get "/tweets/:id/edit" do
      if Helpers.is_logged_in?(session)
        @tweet = Tweet.find(params[:id])
        erb :"tweet/edit"
      else
        redirect to "/login"
      end
    end

    patch "/tweets/:id" do
      @tweet = Tweet.find(params[:id])
      if params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        @tweet.update(content: params[:content])
      end
    end

    delete "/tweets/:id" do
      @tweet = Tweet.find(params[:id])
      if Helpers.is_logged_in?(session) && Helpers.current_user(session).id == @tweet.user_id
        @tweet.delete
      end
      redirect to "/tweets"
    end

end
