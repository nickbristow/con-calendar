# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'donotreply@geeklycon.com'
  layout 'mailer'
end
