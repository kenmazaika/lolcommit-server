class GitCommit < ActiveRecord::Base
  attr_accessible :repo_id, :sha, :image, :email, :raw

  #validates :repo, :presence => true
  validates :sha,  :presence => true

  mount_uploader :image, ImageUploader
  mount_uploader :raw,   ImageUploader

  belongs_to :user
  belongs_to :repo
end
