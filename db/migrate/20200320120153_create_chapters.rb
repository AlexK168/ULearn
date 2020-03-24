class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.string :name
      t.text :info
      t.references :course

      t.timestamps
    end
  end
end
