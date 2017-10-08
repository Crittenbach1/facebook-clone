class Post < ActiveRecord::Base
     has_many :post_likes
     has_many :likes, through: :post_likes
     belongs_to :user
end
