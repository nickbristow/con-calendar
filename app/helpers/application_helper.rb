# frozen_string_literal: true

module ApplicationHelper
  def active_page_class(page_path)
    return 'active' if current_page?(page_path)
  end

  def event_dates
    @event_dates ||= [
      {
        date: '07/18/19', date_string: 'Thursday, July 18, 2019'
      },
      {
        date: '07/19/19', date_string: 'Friday, July 19, 2019'
      },
      {
        date: '07/20/19', date_string: 'Saturday, July 20, 2019'
      },
      {
        date: '07/21/19', date_string: 'Sunday, July 21, 2019'
      }
    ]
  end

  def partial_html(html, length, append_text)
    return html if html.length <= length
    partial = html[0..length]
    malformed_tag = partial.rindex(/<\w(?!\w+>)/)
    partial = partial[0..malformed_tag - 1] if malformed_tag
    opening_tags = partial.scan(/<\w+>/)
    closing_tags = partial.scan(/<\/\w+>/)
    opening_tags.map! { |t| t.insert(1, '/') }
    missing_tags = opening_tags - closing_tags
    missing_tags.reverse.each do |tag|
      partial += tag
    end
    partial.insert(partial.rindex(/<\/p>/), append_text)
  end
end
