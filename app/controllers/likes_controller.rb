class LikesController < ApplicationController



def new
  @like=@likable.likes.new
end
def create
  @like=@likable.likes.create(user_id:current_user.id)
  respond_to do |format|
  if @like.save
    format.turbo_stream
  end 
end

end
def like_params
  params.require(:like).permit(:likable_type,:likeable_id,:user_id)
end
end
