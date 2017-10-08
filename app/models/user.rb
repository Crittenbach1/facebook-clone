class User < ActiveRecord::Base
  has_many :likes
  has_many :likes, through: :posts
end
