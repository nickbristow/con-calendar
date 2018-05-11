# frozen_string_literal: true

module ApplicationHelper
  def active_page_class(page_path)
    return 'active' if current_page?(page_path)
  end
  
  def event_dates
    @event_dates ||= [
      {
        date: '07/19/18', date_string: 'Thursday, July 19, 2018'
      },
      {
        date: '07/20/18', date_string: 'Friday, July 20, 2018'
      },
      {
        date: '07/21/18', date_string: 'Saturday, July 21, 2018'
      },
      {
        date: '07/22/18', date_string: 'Sunday, July 22, 2018'
      }
    ]
  end
end
