class Recipe < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable

  validates :body, presence: true

  def up_points
    (self.votes.select  {|each_vote| each_vote.up_vote == true}).length
  end

  def down_points
    (self.votes.select  {|each_vote| each_vote.up_vote == false}).length
  end

end
