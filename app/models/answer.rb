class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  validates :answer, :presence => true
  validates :user_id, :uniqueness => { :scope => :question_id, :message => "You have authority to write one answer only"}
end
