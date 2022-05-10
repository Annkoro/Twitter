class TweetsController < ApplicationController
  def index
    @tweet = Tweet.all
  end

  def new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @user.tweets.create(tweet_params)
    redirect_to tweets_index_path
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      redirect_to "/",flash: {danger: "投稿を削除しました"}
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
