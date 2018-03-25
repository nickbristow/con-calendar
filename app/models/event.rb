# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  date        :date
#  category    :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
	has_many :appointments
  has_many :users, through: :appointments
  attr_accessor :start_time_hour, :end_time_hour, :start_time_minute, :end_time_minute, :end_time_hour, :end_time_am_pm, :start_time_am_pm

  def attendee_count
  	users.count
  end

  def time_period
  	if start_time && end_time
  		"#{start_time.strftime("%I:%M%p")}-#{end_time.strftime("%I:%M%p")}"
  	else
  		""
  	end
  end

  def self.event_categories(user)
  	if user.admin
  		["official_event", "panel", "game", "outing"]
  	else
  		["game"]
  	end
  end
end


