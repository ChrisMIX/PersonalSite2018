require_relative '../../config/environment.rb'

require 'open-uri'

module ApplicationHelper
  #this method allows us to take an array of candidates and turn them into candidate objects
  def import_candidates(cans_array)
    cans_array.each do |can|
      Candidate.create!(name: can["name"], image_url: can["image_url"], title: can["title"], bio: can["bio"], score: 0)
    end
  end
end
include ApplicationHelper

#here we are taking the results of calling the api, and receiving a string which is then translated to an array in order to allow the import_candidates method to interpret the data
cans = open('https://api.myjson.com/bins/16roa3')
candidate_status = cans.status
candidate_body = cans.read
result = JSON.parse (candidate_body)

#We want to check the api results and make sure we are up to date. If there are additional listings, we want to get rid of the entries we've already accounted for and run the remaining results through our import_candidates method. If we are loading for the first time, run the method
if Candidate.all.length == 0
  import_candidates(result)
elsif result.length > Candidate.all.length
  Candidate.all.length.times do
    result.shift
  end

  import_candidates(result)
end
