class AddAttrToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :school, :string
    add_column :users, :info, :string
    add_column :users, :role, :string
  end
end
