class AddTweetReferenceToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :tweet, null: false, foreign_key: true
  end
end
