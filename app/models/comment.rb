# frozen_string_literal: true

require 'redcarpet'
require 'redcarpet/render_strip'
class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :event
  belongs_to :user

  def text_md
    Comment.markdown.render(text)
  end

  def self.markdown
    @renderer ||= Redcarpet::Render::HTML.new(no_links: true, hard_wrap: true, no_images: true, filter_html: true)
    @markdown ||= Redcarpet::Markdown.new(@renderer)
  end
end
