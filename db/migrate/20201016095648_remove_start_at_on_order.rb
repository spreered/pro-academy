class RemoveStartAtOnOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :start_at
  end
end
