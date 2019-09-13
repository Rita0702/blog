class TweetsController < ApplicationController
  before_action :jump_index, except: [:index]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  def new
    @tweet= Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.destroy
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id
      @tweet.update(tweet_params)
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def jump_index
    redirect_to action: :index unless user_signed_in?
  end

end
