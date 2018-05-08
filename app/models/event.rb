# frozen_string_literal: true

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

require 'redcarpet'
require 'redcarpet/render_strip'

class Event < ApplicationRecord

  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments
  attr_accessor :start_time_hour, :end_time_hour, :start_time_minute, :end_time_minute, :end_time_hour, :end_time_am_pm, :start_time_am_pm

  def attendee_count
    return current_attendees unless current_attendees.nil?
    update(current_attendees: users.count)
    users.count
  end

  def update_attendee_count
    update(current_attendees: users.count)
  end

  def time_period
    if start_time && end_time
      "#{start_time.strftime('%I:%M%p')}-#{end_time.strftime('%I:%M%p')}"
    else
      ''
    end
  end

  def self.event_categories(user)
    if user.admin
      %w[official_event panel game outing]
    else
      ['game']
    end
  end

  def description_md
    Event.markdown.render(description)
  end

  def self.markdown
    @renderer ||= Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, no_images: true, filter_html: true)
    @markdown ||= Redcarpet::Markdown.new(@renderer)
  end

  def category_name
    cat_names = { game: 'Game', official_event: 'Geekly', outing: 'Outing', panel: 'Panel' }
    cat_names[category.to_sym]
  end
end
