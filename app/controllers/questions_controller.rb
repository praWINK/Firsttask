
class QuestionsController < ApplicationController
before_action :authenticate_user!, only: [:new]
 before_action :set_question, only: [:show, :update, :destroy, :edit]
#before_action :check_authorized_user, except: [:index, :show]


 def index
    @questions = Question.all
 end

 def show
  @answers = @question.answers
  @comments = @question.comments

  #@commentable = @answer.commentable
 end

 def new
    @question = current_user.questions.new
 end
 def edit
 end


 def create
    @question = current_user.questions.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: questions_path }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to questions_path, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: questions_path }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end
    #def check_authorized_user
      #@question
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:content)
    end

end
