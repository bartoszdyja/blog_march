class Review < ActiveRecord::Base
  validates_presence_of :content, :user_id, :rating
  belongs_to :product
  belongs_to :user
end
