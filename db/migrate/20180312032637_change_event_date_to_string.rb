# frozen_string_literal: true

class ChangeEventDateToString < ActiveRecord::Migration[5.0]
  def change
    change_column :events, :date, :string
  end
end
