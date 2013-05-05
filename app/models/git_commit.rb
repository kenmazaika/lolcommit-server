class GitCommit < ActiveRecord::Base
  attr_accessible :repo_external_id, :sha, :image, :email, :raw

  validates :sha,  :presence => true

  mount_uploader :image, ImageUploader
  mount_uploader :raw,   ImageUploader

  belongs_to :user
  belongs_to :repo
  self.per_page = 10
  FIREHOSE_HOST = Rails.application.config.firehose['url'] 
  after_commit :post_to_firehose

  def repo_external_id=(external_id)
    repo = Repo.find_by_external_id(external_id)
    self.repo = repo

    if ! repo.blank? && ! user.blank? && !repo.users.include?(user)
      repo.users << self.user
    end
  end

  private

  def post_to_firehose
    begin
      firehose_urls.each do |url|
        HTTParty.put(url, :body => self.to_json)
      end
    rescue

    end
  end

  def firehose_urls
    [
      FIREHOSE_HOST,
      FIREHOSE_HOST + "users/#{self.user_id}"
    ]
  end

end
