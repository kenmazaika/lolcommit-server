class Repo < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :users
  has_many :git_commits

  after_initialize :generate_external_id
  validates :name, :presence => true, :uniqueness => true

  private
  def generate_external_id
    self.external_id ||= UUID.generate(:compact)
  end
end
