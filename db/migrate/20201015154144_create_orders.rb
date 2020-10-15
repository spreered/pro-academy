class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :state, defult: 0, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.references :course
      t.references :user

      t.timestamps
    end
  end
end
