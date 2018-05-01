# frozen_string_literal: true

class AddCurrentUserCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :current_user_count, :integer
    Event.reset_column_information
  end
end
