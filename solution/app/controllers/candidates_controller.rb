require 'open-uri'
class CandidatesController < ApplicationController
  before_filter :authorize

  def index
    @candidates = Candidate.all
  end
end