# frozen_string_literal: true

class AddAppointmentsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :user
      t.belongs_to :event

      t.timestamps
    end
  end
end
