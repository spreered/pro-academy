class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :state, defult: 0, null: false
      t.datetime :start_at
      t.datetime :end_at
      t.integer :amount_cents, null: false
      t.string :amount_currency, default: 'NTD', null:false
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
