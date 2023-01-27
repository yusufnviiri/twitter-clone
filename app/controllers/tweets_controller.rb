class TweetsController < ApplicationController
  before_action :find_tweet ,only: %i[show edit destroy update] 
  before_action :authenticate_user!,except:[:show,:index]
  def index
    @tweets = Tweet.all
    @tweet=Tweet.new
    if current_user
    @user_tweets=current_user.tweets.count
    end
end 
def show
  @tweet=Tweet.find(params[:id])
end
def new
  @tweet=current_user.tweets.build
end
def create
  @tweet=current_user.tweets.build(tweett_params)
    respond_to do |format|
      if @tweet.save
        format.html {redirect_to tweets_path,notice:"tweeted"}
        format.json{render :show,status: :ok,location:@tweet}
      else
        format.html {render :new,status: :unprocessable_entity}
        format.json{render json: @tweet.errors,status: :unprocessable_entity}
      end    
  end
end
def edit

end
def update
  @tweet.update(tweett_params)
  respond_to do |format|
    if @tweet.update(tweett_params)
      format.html{redirect_to tweets_path,notice:"Updated well"}
      format.json{render :show ,status: :ok,location:@tweet}
    else
      format.html{render :edit,status: :unprocessable_entity}
      format.json {render json:@tweet.errors,status: :unprocessable_entity}
    end
  end
end
def destroy
  @tweet.destroy
  redirect_to tweets_path
end
def tweett_params
  params.require(:tweet).permit(:tweeet,:user_id)
end
def find_tweet
  @tweet=Tweet.find(params[:id])
end

end
