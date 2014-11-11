class Api::V1::AnswersController < Api::V1::BaseController
  authorize_resource

  def index
    @question = Question.find(params[:question_id])
    respond_with @answers = @question.answers
  end

  def create
    @question = Question.find(params[:question_id])
    respond_with @answer = @question.answers.create(answer_params)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end