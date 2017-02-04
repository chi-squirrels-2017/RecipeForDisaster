class Question < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :voteable
  has_many :recipes
  has_many :comments, as: :commentable

  def up_points
    self.votes.where(["up_vote = ?", true]).count
  end

  def down_points
    self.votes.where(["up_vote = ?", false]).count
  end

  def has_no_winning_vote
    self.recipes.find_by(best_answer: true) == nil
  end

end
