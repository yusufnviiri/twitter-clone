class Tweet < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    belongs_to :tweet,optional: true
    has_many :likes , as: :likable
    validates :tweeet,presence:true
  

 

        def tweet_type
            if tweet_id? && tweeet?
              "quote-tweet"
            elsif tweet_id?
              "retweet"
            else
              "tweets"
            end
        end


end
