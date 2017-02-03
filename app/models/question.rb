class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :voteable
  has_many :recipes
  has_many :comments, as: :commentable

  def up_points
    (self.votes.select  {|each_vote| each_vote.up_vote == true}).length
  end

  def down_points
    (self.votes.select  {|each_vote| each_vote.up_vote == false}).length
  end
end
