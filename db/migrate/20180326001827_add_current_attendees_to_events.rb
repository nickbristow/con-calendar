# frozen_string_literal: true

class AddCurrentAttendeesToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :current_attendees, :integer
  end
end
