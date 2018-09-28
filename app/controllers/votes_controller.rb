class VotesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    #here we are managing the voting. depending on whether or not we have voted, we create a vote object or simply change the vote status and candidate score

    candidate = Candidate.find(params[:can])
    user = User.find(params[:current_user])
    vote = Vote.where(user_id: user.id, candidate: candidate.id)[0]

    if vote == nil
      if params[:status] == "up"
        Vote.create!(user_id: user.id, candidate_id: candidate.id, status: "up")
        candidate.score += 1
        candidate.save
      elsif params[:status] == "down"
        Vote.create!(user_id: user.id, candidate_id: candidate.id, status: "down")
        candidate.score -= 1
        candidate.save
      end
    elsif vote
      if params[:status] == "up"
        vote.status = "up"
        vote.save
        candidate.score += 1
        candidate.save
      elsif params[:status] == "down"
        vote.status = "down"
        vote.save
        candidate.score -= 1
        candidate.save
      end
    end

    redirect_to '/candidates'
  end

end