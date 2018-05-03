require_relative '../../config/environment.rb'
require 'open-uri'

module ApplicationHelper
  def import_candidates(cans_array)
    cans_array.each do |can|
      Candidate.create!(name: can["name"], image_url: can["image_url"], title: can["title"], bio: can["bio"], score: 0)
    end
  end
end
include ApplicationHelper

cans = open('https://api.myjson.com/bins/16roa3')
candidate_status = cans.status
candidate_body = cans.read
result = JSON.parse (candidate_body)

if Candidate.all.length == 0
  import_candidates(result)
elsif result.length > Candidate.all.length
  Candidate.all.length.times do
    result.shift
  end

  import_candidates(result)
end
