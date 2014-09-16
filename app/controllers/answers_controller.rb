class AnswersController < ApplicationController
  before_action :load_answer, only: [:update]

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to @answer.question
    else
      render 'questions/show'
    end
  end

  def update
  	if @answer.update(answer_params)
  	  redirect_to @answer.question
  	else
  	  render 'questions/show'
  	end
  end

  private

  def load_answer
  	@answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
