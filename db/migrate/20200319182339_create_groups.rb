class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.integer :size
      t.integer :max_size
      t.references :teacher
      t.timestamps
    end
  end
end
