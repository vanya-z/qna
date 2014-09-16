class AnswersController < ApplicationController
  
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to @answer.question
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :question_id)
  end
end
