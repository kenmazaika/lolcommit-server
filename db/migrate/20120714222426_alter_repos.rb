class AlterRepos < ActiveRecord::Migration
  def up
    #remove_column :repos, :user_name
    add_column    :repos, :external_id, :string
    add_index     :repos, :external_id
  end

  def down
    add_column    :repos, :username, :string
    remove_column :repos, :external_id
  end
end
