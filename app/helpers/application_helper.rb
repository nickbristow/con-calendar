# frozen_string_literal: true

module ApplicationHelper
  def active_page_class(page_path)
    return 'active' if current_page?(page_path)
  end
end
