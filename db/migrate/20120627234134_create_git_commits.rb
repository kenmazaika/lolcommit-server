class CreateGitCommits < ActiveRecord::Migration
  def change
    create_table :git_commits do |t|
      t.string :image
      t.string :sha
      t.string :repo
      t.string :email
      t.timestamps
    end

    add_index :git_commits, :sha
    add_index :git_commits, [:repo, :sha]
    add_index :git_commits, :email
  end
end
