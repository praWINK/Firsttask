class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  validates :answer, :presence => true
  validates :user_id, :uniqueness => { :scope => :question_id, :message => "You have authority to write one answer only"}
def check_history?
 self.history_id.blank?
end

def self.show_history(num)
 where("history_id IS NULL AND id =? OR history_id =? AND id != ?", num, num, num).order("id DESC").first
end

def self.list_comment_history(num,not_num)
 where("history_id IS NULL AND id =? XOR history_id =? AND id != ? AND id != ?",num,num,num, not_num).order("id DESC")
end

end


