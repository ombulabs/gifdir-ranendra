class HomeController < ApplicationController
  
  def index
    @images = Image.page(params[:page])
  end

end
