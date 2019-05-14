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
  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :category, presence: true
  validates :location, presence: true
  validates :max_attendees, numericality: { only_integer: true, greater_than: 1, less_than_or_equal_to: 500 }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments
  attr_accessor :start_time_hour, :end_time_hour, :start_time_minute, :end_time_minute, :end_time_hour, :end_time_am_pm, :start_time_am_pm

  # scope :hide_full_games -> {(where('max_attendees<current_attendees'))}
  scope :official_event, -> {(where(category: 'official_event'))}
  scope :panel, -> {(where(category: 'panel'))}
  scope :game, -> {(where(category: 'game'))}
  scope :outing, -> {(where(category: 'outing'))}
  # scope :hide_past_events, -> {(where('date !~* ?', '18'))}
  # https://www.sitepoint.com/dynamically-chain-scopes-to-clean-up-large-sql-queries/

  def attendee_count
    return current_attendees unless current_attendees.nil?
    update(current_attendees: users.count)
    users.count
  end

  def update_attendee_count
    update(current_attendees: users.count)
  end

  def max_attendee_count
    max_attendees || 500
  end

  def time_period
    if start_time && end_time
      "#{day_of_week} <strong>#{start_time.strftime('%I:%M%p')}-#{end_time.strftime('%I:%M%p')}</strong>".html_safe
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

  def self.internal_markdown
    @renderer ||= Redcarpet::Render::HTML.new(no_links: false, hard_wrap: true, no_images: true, filter_html: false)
    @markdown ||= Redcarpet::Markdown.new(@renderer)
  end

  def category_name
    return 'Game' if category.blank?
    cat_names = { game: 'Game', official_event: 'Geekly', outing: 'Outing', panel: 'Panel' }
    cat_names[category.to_sym]
  end

  def owner_name
    @owner ||= User.where(id: owner_id)
    if !@owner.blank?
      @owner.first.name
    else
      ''
    end
  end

  def day_of_week
    days = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
    days[Date.strptime(date, '%m/%d/%y').wday]    
  end

  def self.send_chain(methods)
    methods.inject(self, :send)
  end
end
