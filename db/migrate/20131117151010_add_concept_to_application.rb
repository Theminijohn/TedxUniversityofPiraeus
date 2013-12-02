class AddConceptToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :concept, :text
  end
end
