# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to events_path
    else
      redirect_to user_session_path
    end
  end

  def letsencrypt
      # use your code here, not mine
    render text: "wIU181Wz2oeqZnDycZFoycU--3tc_389dIy8JMbdlNo.aovLs7n9uAOYY5P1wcGKXnG5YPfpRvImU-VQiWZfP-s"
  end
end
