# frozen_string_literal: true

# Class for adding programing language column to Users
class AddProgramingLanguageToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :programing_language, :string, null: false
  end
end
