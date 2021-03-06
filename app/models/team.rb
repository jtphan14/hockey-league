class Team < ActiveRecord::Base
  belongs_to :league
  belongs_to :team_admin
  has_many   :posts
  has_many   :players
  has_many   :trades
  has_many   :games

  def teamcity
    self.city + " " + self.name
  end

  def readable_date
    self.created_at.strftime("%B %d, %Y")
  end
end
