class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  has_many :answered_users, source: :user, through: :answers
  has_many :comments, as: :commentable
end
