class User < ActiveRecord::Base
  attr_accessible :github_id, :email, :name, :token
  before_create :generate_api_credentials
  has_many :git_commits
  has_and_belongs_to_many :repos

  def as_json(options={})
    super(options).slice!("api_key", "api_secret")
  end

  private

  def generate_api_credentials
    self.api_key    = UUID.generate(:compact)
    self.api_secret = UUID.generate(:compact)
  end
end
