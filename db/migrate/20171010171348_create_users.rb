# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :preffered_name
      t.string :house
      t.boolean :admin
      t.string :twitter

      t.timestamps
    end
  end
end
