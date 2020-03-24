class RemoveSizeFromGroups < ActiveRecord::Migration[6.0]
  def change
    remove_column :groups, :size, :integer
  end
end
