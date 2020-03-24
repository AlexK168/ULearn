class CreateLectures < ActiveRecord::Migration[6.0]
  def change
    create_table :lectures do |t|
      t.integer :num
      t.references :chapter
      t.text :content

      t.timestamps
    end
  end
end
