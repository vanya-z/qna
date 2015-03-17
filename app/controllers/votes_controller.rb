class VotesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_votable
  before_action :load_vote

  def create
    @votable.vote_by voter: current_user, vote: @vote
  end

  private

  def load_votable
    @votable = Question.find(params[:question_id]) if params[:question_id]
    @votable ||= Answer.find(params[:answer_id])    
  end

  def load_vote
    @vote = params[:vote] == 'up' ? 'up' : 'down'
  end
end