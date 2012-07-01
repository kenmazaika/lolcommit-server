class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.integer :github_id
      t.string  :email
      t.string  :token
      t.string  :api_key
      t.string  :api_secret
      t.timestamps
    end

    add_index :users, :github_id
    add_index :users, :api_key
  end
end
