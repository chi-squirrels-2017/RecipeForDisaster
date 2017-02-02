class Recipe < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable


  def up_points
    (votes.select do {|each_vote| votes.up_vote == true}).length
  end

  def down_points
    (votes.select do {|each_vote| votes.up_vote == false}).length
  end

end
