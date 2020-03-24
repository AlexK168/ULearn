class CreateGroupsStudentsJoinTable < ActiveRecord::Migration[6.0]
  def change

    add_index :groups_users, :student_id
    add_index :groups_users, :group_id
  end
end
