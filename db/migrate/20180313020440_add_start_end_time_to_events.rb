# frozen_string_literal: true

class AddStartEndTimeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
  end
end
