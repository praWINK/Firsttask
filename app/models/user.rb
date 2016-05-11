class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :Firstname, :presence => true, :length => { :minimum => 5 }
  validates :lastname, :presence => true, :length => { :minimum => 5 }
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :answered_questions, source: :question, through: :answers

def anscount
  "Answer"
end


end
