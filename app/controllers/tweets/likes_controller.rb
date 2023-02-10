class Tweets::LikesController<LikesController
    before_action :set_likable


    private
    def set_likable

        @likable=Tweet.find(params[:tweet_id])
    end
end