class AddCvqToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :cvq, :text
  end
end
