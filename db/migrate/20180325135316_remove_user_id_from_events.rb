# frozen_string_literal: true

class RemoveUserIdFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :user_id
  end
end
