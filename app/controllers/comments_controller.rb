class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, except: :create
  before_action :load_parent, only: :create

  respond_to :js

  def create
    respond_with(@comment = @parent.comments.create(comment_params.merge(user_id: current_user.id)))
  end

  def update
    @comment.update(comment_params)
    respond_with @comment
  end

  def destroy
    respond_with(@comment.destroy)
  end

  private

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def load_parent
    @parent = Question.find(params[:question_id]) if params[:question_id]
    @parent ||= Answer.find(params[:answer_id])    
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
