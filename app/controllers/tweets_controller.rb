class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
   else
     redirect to '/login'
   end
 end

 post '/tweets' do
   if logged_in?
     @tweet = current_user.tweets.new(:content => params[:content])
      if params[:content] != ""
        @tweet.save
        redirect("/tweets/#{@tweet.id}")
      else
        redirect to "/tweets/new"
      end
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = current_user.tweets.find_by(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      @tweet = current_user.tweets.find_by(params[:id])
      if params[:content] != ""
        @tweet.update(:content => params[:content])
        @tweet.save
        redirect("/tweets/#{@tweet.id}")
      else
        redirect("/tweets/#{@tweet.id}/edit")
      end
    else
      redirect to "/login"
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = current_user.tweets.find_by(params[:id])
      @tweet.delete
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end



end
