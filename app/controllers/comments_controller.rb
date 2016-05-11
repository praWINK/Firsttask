class CommentsController < ApplicationController

  before_action :set_comment, only:[:show, :edit, :update, :destroy]
  before_action :find_question, only:[:show, :edit, :update, :destroy, :create, :new]

  def create
    commentable= find_commentable
    @commentable= commentable.comments.new(comment_params)
    @commentable.user = current_user
    if @commentable.save(comment_params)
      if (@commentable.commentable_type == 'Question')
        redirect_to @question, notice: 'question comment was successfully created.'
      else
        redirect_to @question, notice: 'Answer comment was successfully created.'
      end
    else
      render :new
    end
  end


  def edit
  end

  def destroy
    #find_question
    #@commentable = @question.comments.where(:id => params[:id]).first
    @commentable.destroy
    if (@commentable.commentable_type == 'Question')
      redirect_to @question, notice: 'question comment was successfully destroyed.'
    else
      redirect_to @question, notice: 'Answer comment was successfully destroyed.'
    end
  end

  def update
    find_question
    #@commentable = @question.comments.where(:id => params[:id]).first
    @commentable.update(comment_params)
    if (@commentable.commentable_type == 'Question')
      redirect_to @question, notice: 'question comment was successfully updated.'
    else
      redirect_to @question, notice: 'Answer comment was successfully updated.'
    end
  end



  def show
  end

  def index
    @comments = Comment.all
  end

  def new
    commentable= find_commentable
    @commentable= commentable.comments.new
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def find_commentable
     if params[:question_id] && params[:answer_id]
       klass = "answers"
       id = params[:answer_id]
     else
       klass = "questions"
       id = params[:question_id]
     end
     return "#{klass}".singularize.classify.constantize.find(id)
 end
  def set_comment
    @commentable = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:comment)
  end

  def find_question
    @question = Question.find params[:question_id]
  end


end
