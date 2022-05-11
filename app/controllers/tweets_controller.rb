class TweetsController < ApplicationController
  def index
    @tweet = Tweet.all
  end

  def new
    @user = User.find(params[:user_id])
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    redirect_to user_tweets_path
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    if @tweet.destroy
      redirect_to "/",flash: {danger: "投稿を削除しました"}
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end
end
