class AddSecretSantaToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :secret_santa_id, :integer
    add_foreign_key :users, :users, column: :secret_santa_id
  end
end
