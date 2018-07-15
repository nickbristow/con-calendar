# frozen_string_literal: true

Raygun.setup do |config|
  config.api_key = 'tg6PV57H8w6esrgo0jUuCQ=='
  config.filter_parameters = Rails.application.config.filter_parameters

  # The default is Rails.env.production?
  # config.enable_reporting = !Rails.env.development? && !Rails.env.test?
end
