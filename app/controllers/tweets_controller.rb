class TweetsController < ApplicationController
  before_action :find_tweet ,only: %i[show edit destroy update] 
  before_action :authenticate_user!,except:[:show,:index]
  def index  
    @tweet=Tweet.new
    @likes=Like.all


      @tweets = Tweet.all.order(created_at: :desc)
      @notweet="Nothing to show Here"
    if current_user
    @user_tweets=current_user.tweets.count
    end
end 
def show
  @tweet = Tweet.find(params[:id])
  @comment = Comment.new
  @comments = @tweet.comments.order(created_at: :desc)
end

  

def destroy
  @tweet.destroy
  
  redirect_to tweets_path
end
def new
  @tweet=current_user.tweets.build
end
def retweet
  @tweet=Tweet.find(params[:id])
  retweet=current_user.tweets.new(tweet_id: @tweet.id)
  respond_to do |format|
    if retweet.save
      format.turbo_stream
    else
      format.html {redirect_back fallback_location: @tweet,notice:"Retweeted"}
    end
  end
end
def like

  @tweet=Tweet.find(params[:id])
  @like=Like.create(tweet_id: @tweet.id,user_id:current_user.id)
  respond_to do |format|

 if @like.save
  format.turbo_stream 

 end
end
end

def create
  @tweet=current_user.tweets.build(tweett_params)

    respond_to do |format|
      if @tweet.save
        format.turbo_stream 
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

def tweett_params
  params.require(:tweet).permit(:tweeet,:user_id,:tweet_id)
end
def find_tweet
  @tweet=Tweet.find(params[:id])
end

end
