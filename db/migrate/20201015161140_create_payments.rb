class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :state, default: 0, null: false
      t.integer :amount_cent, null: false
      t.string :amount_currency, default: 'NTD', null:false
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
