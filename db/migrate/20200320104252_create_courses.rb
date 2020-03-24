class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :duration
      t.text :info
      t.references :teacher

      t.timestamps
    end
  end
end
