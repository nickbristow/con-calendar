# frozen_string_literal: true

class AddOwnerCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :owner_id, :integer
    add_column :events, :location, :text
  end
end
