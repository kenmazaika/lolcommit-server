class AnimatedGifsController < ApplicationController

  def create
    gif = AnimatedGif.create(params[:animated_gif])

    if gif.valid?
      render :json => gif
    else
      render :json => {:errors => gif.errors.as_json}, :status => :unprocessable_entity
    end
  end
end
