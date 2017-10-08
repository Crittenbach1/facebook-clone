class Like < ActiveRecord::Base
     has_many :post_likes
     has_many :posts, through: :post_likes
     belongs_to :user, through: :post
end
