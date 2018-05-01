# frozen_string_literal: true

class AddMaxAttendeesToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :max_attendees, :integer
  end
end
