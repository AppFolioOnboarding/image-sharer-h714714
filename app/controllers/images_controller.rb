class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_url: params[:image][:image_url], tag_list: params[:image][:tag_list])

    if @image.valid?
      @image.save!
      redirect_to image_path(@image.id)
    else
      render 'new'
    end
  end

  def show
    image = Image.find(params[:id])
    @url = image.image_url
    @tags = image.tag_list
  end

  def index
    @images = if params[:tag_list].present?
                Image.tagged_with(params[:tag_list])
              else
                Image.all
              end
  end
end
