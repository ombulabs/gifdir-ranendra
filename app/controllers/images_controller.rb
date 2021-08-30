class ImagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @images = current_user.images
  end

  def new
    @image = current_user.images.build
  end

  def create
    @image = current_user.images.build(gif_image_params)
    if @image.save
      redirect_to images_path, message: "Successfully created!"
    else
      render 'new'
    end
  end

  private
  def gif_image_params
    params.require(:image).permit(:name, :gif_file)
  end
end
