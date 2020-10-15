class AddAccessTokenOnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_token_expired_at, :datetime
    add_index :users, :access_token, unique: true
  end
end
