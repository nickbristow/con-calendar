# frozen_string_literal: true

class AddUserCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :user_count, :integer
  end
end
