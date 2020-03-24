class AddStateToPapers < ActiveRecord::Migration[6.0]
  def change
    add_column :papers, :state, :string
  end
end
