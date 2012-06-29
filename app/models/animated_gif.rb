class AnimatedGif < ActiveRecord::Base
  include Magick
  attr_accessible :shas, :image
  mount_uploader :image, ImageUploader
  before_create :store_animation 
  after_create :close_file
  # TODO: this code needs tests, also should be
  # refactored.  Don't pipe to shell to create
  # directory.  Don't redundantly determine urls.
  def store_animation
    split_shas = self.shas.split(',')
    commits = GitCommit.where(:sha => split_shas)
    id = UUID.generate(:compact)
    `mkdir #{Rails.root}/tmp/#{id}`
    commits.collect do |commit|
      image_req = HTTParty.get(commit.image.to_s)
      if image_req.success?
        File.open( "#{Rails.root}/tmp/#{id}/#{commit.sha}.jpg", "wb") do |image|
          image << image_req.body
        end
      end
    end

    images = split_shas.collect do |sha|
      path = "#{Rails.root}/tmp/#{id}/#{sha}.jpg"
      if File.exist?(path)
        path
      else
        nil
      end
    end.compact

    animation = ImageList.new(*images)
    animation.delay = 75
    animation.write("#{Rails.root}/tmp/#{id}.gif")
    @file = File.open("#{Rails.root}/tmp/#{id}.gif")
    self.image = @file
  end

  def close_file
    @file.close if @file
  end
end
