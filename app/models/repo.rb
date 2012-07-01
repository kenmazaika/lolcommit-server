class Repo < ActiveRecord::Base
  attr_accessible :name, :username
  has_and_belongs_to_many :users
  has_many :git_commits
end
