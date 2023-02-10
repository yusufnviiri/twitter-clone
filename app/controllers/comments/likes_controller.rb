class Comments::LikesController<LikesController
    before_action :set_likable


    private
    def set_likable
        @likable= Comment.find(params[:comment_id])
    end
end