class AnswersController < ApplicationController

  before_action only: [:new, :create]

  def create
    find_question
    @answer = @question.answers.build(answer_params.merge({user_id: @question.user_id}))
    if @answer.save
      redirect_to question_path(@question), notice: 'answer was successfully created.'
    else
      render :new
    end
  end


  def edit
    find_question
    @answer = @question.answers.where(:id => params[:id]).first
  end

  def destroy
    find_question
    @answer = @question.answers.where(:id => params[:id]).first
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: 'answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    find_question
    @answer = @question.answers.where(:id => params[:id]).first
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to  @question, notice: 'answer was successfully updated.' }
        format.json { render :show, status: :ok, location:  @question }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    find_question
    @answer = @question.answers.find(params[:id])
  end

  def index
    @answers = Answer.all
  end

  def new
    find_question
    @answer = @question.answers.build
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:answer)
  end

  def find_question
    @question = Question.find params[:question_id]
  end


end
