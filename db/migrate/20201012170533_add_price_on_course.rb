class AddPriceOnCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :price_cents, :integer, null: false, default: 0
    add_column :courses, :price_currency, :string, null: false, default: 0
  end
end
