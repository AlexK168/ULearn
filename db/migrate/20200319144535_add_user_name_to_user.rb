class AddUserNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :login, :string
    add_column :users, :name, :string
  end
end
