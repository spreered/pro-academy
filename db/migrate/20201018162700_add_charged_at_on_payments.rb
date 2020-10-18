class AddChargedAtOnPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :charged_at, :datetime
  end
end
