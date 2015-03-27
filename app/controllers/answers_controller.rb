class AnswersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_question, only: [:create]
  before_action :load_answer, except: [:create]
  before_action :set_question, except: [:edit, :create]

  respond_to :js

  def edit    
  end

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user_id: current_user.id)))
  end

  def update    
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question, anchor: "answer_body_#{@answer.id}")
    else
      render :edit
    end
  end

  def destroy
    respond_with(@answer.destroy)
  end

  def accept    
    respond_with(@answer.accept)
    authorize! :accept, @answer
  end

  def discard
    respond_with(@answer.discard)
    authorize! :discard, @answer
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = @answer.question
  end

  def answer_params
    params.require(:answer).permit(:body, :question_id, attachments_attributes: [:id, :file, :_destroy])
  end
end
