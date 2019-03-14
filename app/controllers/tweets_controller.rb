class TweetsController < ApplicationController

    get '/tweets' do
        redirect to '/login' if !logged_in?
        @tweets = Tweet.all
        erb :'/tweets/tweets'
    end

    get '/tweets/new' do
        redirect to '/login' if !logged_in?
        erb :'/tweets/new'
    end

    post '/tweets' do
        redirect to '/login' if !logged_in?
        redirect to '/tweets/new' if params[:content] == ""

        @tweet = Tweet.create(content: params[:content])
        User.find(session[:user_id]).tweets << @tweet
        redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id' do
        redirect to '/login' if !logged_in?
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show_tweet'
    end

    get '/tweets/:id/edit' do
        redirect to '/login' if !logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet && @tweet.user_id == current_user.id
            erb :'/tweets/edit_tweet'
        else
            redirect to '/tweets'
        end
    end

    patch '/tweets/:id' do
        redirect to '/login' if !logged_in?

        @tweet = Tweet.find(params[:id])
        redirect to "/tweets/#{@tweet.id}/edit" if params[:content] == ""

        if @tweet && @tweet.user_id == current_user.id
            @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
        else
            redirect to '/tweets'
        end
    end

    delete '/tweets/:id/delete' do
        redirect to '/login' if !logged_in?

       @tweet = Tweet.find_by(id: params[:id])

        if @tweet && @tweet.user_id == current_user.id
            @tweet.destroy
        else
            redirect to '/tweets'
        end
    end

end