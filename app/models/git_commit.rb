class GitCommit < ActiveRecord::Base
  attr_accessible :repo, :sha, :image, :email

  validates :repo, :presence => true
  validates :sha,  :presence => true

  mount_uploader :image, ImageUploader
  
end
