class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.references :lecture
      t.text :content
      t.integer :points
      t.datetime :deadline

      t.timestamps
    end
  end
end
