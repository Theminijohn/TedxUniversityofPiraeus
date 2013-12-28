class AddSpecsToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :specs, :string
  end
end
