class GitCommit < ActiveRecord::Base
  attr_accessible :repo_external_id, :sha, :image, :email, :raw

  validates :sha,  :presence => true

  mount_uploader :image, ImageUploader
  mount_uploader :raw,   ImageUploader

  belongs_to :user
  belongs_to :repo

  def repo_external_id=(external_id)
    repo = Repo.find_by_external_id(external_id)
    self.repo = repo

    if ! repo.blank? && ! user.blank? && !repo.users.include?(user)
      repo.users << self.user
    end
  end

end
