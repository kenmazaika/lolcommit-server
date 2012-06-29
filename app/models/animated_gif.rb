class AnimatedGif < ActiveRecord::Base
  include Magick
  attr_accessible :shas, :image
  mount_uploader :image, ImageUploader
  
  # TODO: this code needs tests, also should be
  # refactored.  Don't pipe to shell to create
  # directory.  Don't redundantly determine urls.
  def self.create_from_shas(shas)
    commits = GitCommit.where(:sha => shas)
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

    images = shas.collect do |sha|
      path = "#{Rails.root}/tmp/#{id}/#{sha}.jpg"
      if File.exist?(path)
        path
      else
        nil
      end
    end.compact
    puts images.inspect

    animation = ImageList.new(*images)
    animation.delay = 75
    animation.write("#{Rails.root}/tmp/#{id}.gif")
    File.open("#{Rails.root}/tmp/#{id}.gif") do |file|
      return AnimatedGif.create(:shas => shas.join(','), :image => file)
    end

  end
end
