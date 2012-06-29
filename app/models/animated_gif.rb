class AnimatedGif < ActiveRecord::Base
  include Magick
  attr_accessible :shas, :image
  mount_uploader  :image, ImageUploader

  before_create   :store_animation 
  after_create    :close_file

  validates :shas, :presence => true
  validate  :validate_shas_has_commits

  private

  def store_animation
    fetch_images
    animation = generate_animation
    self.image = animation

    ! animation.blank?
  end

  def fetch_images
    commits = GitCommit.where(:sha => split_shas)
    Dir::mkdir(directory)
    commits.collect do |commit|
      image_req = HTTParty.get(commit.image.to_s)
      if image_req.success?
        File.open( "#{directory}/#{commit.sha}.jpg", "wb") do |image|
          image << image_req.body
        end
      end
    end
  end

  def image_files
    images = split_shas.collect do |sha|
      path = "#{directory}/#{sha}.jpg"
      if File.exist?(path)
        path
      else
        nil
      end
    end.compact
  end

  def generate_animation
    files = image_files
    if files.blank?
      self.errors.add(:shas, 'No files available in s3')
      return nil
    end
    animation = ImageList.new(*files)
    animation.delay = 75
    animation.write("#{Rails.root}/tmp/#{uuid}.gif")
    @file = File.open("#{Rails.root}/tmp/#{uuid}.gif")
  end

  def close_file
    @file.close if @file
  end

  def split_shas
    @split_shas ||= self.shas.try(:split, ',')
  end

  def directory
    @directory ||= "#{Rails.root}/tmp/#{uuid}"
  end

  def uuid
    @uuid ||= UUID.generate(:compact)
  end

  def validate_shas_has_commits
    commits = GitCommit.where(:sha => split_shas)
    if commits.blank?
      self.errors.add(:shas, "No valid shas")
    end
  end
end
