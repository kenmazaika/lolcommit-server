class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.integer :github_id
      t.string  :email
      t.string  :token
      t.timestamps
    end
  end
end
