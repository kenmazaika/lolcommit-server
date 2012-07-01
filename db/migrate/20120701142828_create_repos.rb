class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :username
      t.string :name
      t.timestamps
    end

    add_index :repos, [:username, :name]

    remove_column :git_commits, :repo
    add_column    :git_commits, :repo_id, :integer
    add_index     :git_commits, :repo_id

    create_table :repos_users, :id => false do |t|
      t.integer :repo_id
      t.integer :user_id
    end

    add_index :repos_users, [:repo_id, :user_id]
  end
end
