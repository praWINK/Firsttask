class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  #validates :user_id, :uniqueness => { :scope => :question_id, :message => "You have authority to write one comment only"}
end
