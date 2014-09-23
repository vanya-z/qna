class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_answer, except: [:create]

  def create
    @question.answers.create(answer_params)
  end

  def update    
    if @answer.update(answer_params)
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    redirect_to @question
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
