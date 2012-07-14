class AlterGitCommitAddRaw < ActiveRecord::Migration
  def up
    add_column :git_commits, :raw, :string
  end

  def down
    remove_column :git_commits, :raw
  end
end
