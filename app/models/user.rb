class User < ActiveRecord::Base
  has_many :questions
  has_many :votes
  has_many :comments
  has_many :recipes

  include BCrypt
  validates :email, :presence => true
  validates :hashed_password, :presence => true
  validates :email, :uniqueness => true

  def password
    @password ||= Password.new(hashed_password)
  end

  def password=(plain_password)
    @password = Password.create(plain_password)
    self.hashed_password = @password
  end

  def authenticate?(check_password)
    self.password == check_password
  end
end
