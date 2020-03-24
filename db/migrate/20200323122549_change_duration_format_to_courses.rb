class ChangeDurationFormatToCourses < ActiveRecord::Migration[6.0]
  def change
    remove_column :courses, :duration, :string
    add_column :courses, :duration, :integer
  end
end
