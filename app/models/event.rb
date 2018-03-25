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
end
