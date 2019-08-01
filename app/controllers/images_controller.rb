class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_url: params[:image][:image_url])

    if @image.valid?
      @image.save!
      redirect_to images_path(@image.id)
    else
      render 'new'
    end
  end

  def show
    image = Image.find(params[:id])
    @url = image.image_url
  end

  def index
    @images = Image.all
  end
end
