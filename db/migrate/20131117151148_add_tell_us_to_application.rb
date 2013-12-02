class AddTellUsToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :tell_us, :text
  end
end
