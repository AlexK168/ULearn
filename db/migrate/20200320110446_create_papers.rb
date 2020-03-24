class CreatePapers < ActiveRecord::Migration[6.0]
  def change
    create_table :papers do |t|
      t.references :student
      t.references :assignment
      t.integer :grade

      t.timestamps
    end
  end
end
