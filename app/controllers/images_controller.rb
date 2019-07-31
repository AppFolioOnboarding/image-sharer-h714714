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

end
