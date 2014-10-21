class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_comment, except: :create
  before_action :load_parent, only: :create

  def create
    @comment = @parent.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
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
