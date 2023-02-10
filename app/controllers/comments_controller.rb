class CommentsController < ApplicationController
  before_action :find_comment ,only: %i[edit show update destroy]
  def index
    @comments=Comment.all
  end

  def like


    @tweet=Tweet.find(params[:tweet_id])
    @comment=@tweet.comments.find(params[:id])
    @like=Like.create(tweet_id: @tweet.id,user_id:current_user.id)
    respond_to do |format|
  
   if @like.save
    format.turbo_stream 
  
   end
  end
  end
  def show
    
  end
def new
  @comment=Comment.new
  @tweet=Tweet.find(params[:tweet_id])
end
def create

  @tweet=Tweet.find(params[:tweet_id])
  @comment=@tweet.comments.create(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to tweets_path ,notice: 'Comment was successfully created.'}
        format.json{render :show ,status: :ok,location:@comment}
      else
        format.html { render :new ,status: :unprocessable_entity}
        format.json {render json:@comment.errors,status: :unprocessable_entity}

    end
  end

end

def destroy
  @comment.destroy
  redirect_to root_path, notice: 'Comment was deleted'
end
  def comment_params
    params.require(:comment).permit(:body,:tweet_id,:user_id)
  end
  def find_comment
    @comment=Comment.find(params[:id])
    @tweet=Tweet.find(params[:tweet_id])


  end
end
