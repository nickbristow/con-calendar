# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'help@geeklyconcalendar.com'
  layout 'mailer'
end
