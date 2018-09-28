class Candidate < ActiveRecord::Base
  has_many :votes

  def init
    self.score ||= 0
  end
end
