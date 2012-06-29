class AnimatedGif < ActiveRecord::Base
  include Magick
  attr_accessible :shas, :image
  mount_uploader :image, ImageUploader
  before_create :store_animation 
  after_create :close_file
  # TODO: this code needs tests, also should be
  # refactored.  Don't pipe to shell to create
  # directory.  Don't redundantly determine urls.

  private

  def store_animation
    fetch_images
    self.image = generate_animation
  end

  def fetch_images
    commits = GitCommit.where(:sha => split_shas)
    `mkdir #{directory}`
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
    animation = ImageList.new(*image_files)
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
end
