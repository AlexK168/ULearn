class AddStateToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :state, :string
  end
end
