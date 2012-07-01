class AlterGitCommitAddUserId < ActiveRecord::Migration
  def up
    add_column :git_commits, :user_id, :integer
    add_index :git_commits, :user_id
  end

  def down
    remove_column :git_commits, :user_id
  end
end
