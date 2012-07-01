class GitCommit < ActiveRecord::Base
  attr_accessible :repo_id, :sha, :image, :email

  validates :repo, :presence => true
  validates :sha,  :presence => true

  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :repo
  
end
