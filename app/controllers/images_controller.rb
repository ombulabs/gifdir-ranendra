class ImagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @images = current_user.images.order(created_at: :desc).page(params[:page])
  end

  def new
    @image = current_user.images.build
    @top_ten_tags = ActsAsTaggableOn::Tag.most_used(10).collect{|tag| tag.name}
  end

  def create
    @image = current_user.images.build(gif_image_params)
    @image.tag_list = merge_tag_list
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

  def merge_tag_list
    if params[:existing_tags].nil?
      params[:image][:tag_list]
    else 
      (params[:image][:tag_list].split(',') + params[:existing_tags]).join(" ")
    end
  end
end
