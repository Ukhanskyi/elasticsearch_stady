# frozen_string_literal: true

# Class for creating migration Cities
class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_reference :users, :city, index: true
  end
end
