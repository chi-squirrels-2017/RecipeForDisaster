class User < ActiveRecord::Base
  has_many :questions
  has_many :votes
  has_many :comments
  has_many :recipes
end
