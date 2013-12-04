class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :full_name
      t.string :email
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
