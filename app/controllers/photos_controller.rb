class PhotosController < ApplicationController

  def create
    @room = Room.find_by id: params[:room_id]
    if params[:images]
      params[:images].each do |image|
        @room.photos.create(image: image)
      end
    end
    @photos = @room.photos
    redirect_back(fallback_location: request.referer, notice: t(".saved"))
  end

  def destroy
    @photo = Photo.find_by id: params[:id]
    @room = @photo.room
    @photo.destroy
    @photos = Photo.where room_id: @room.id
    respond_to :js
  end
end
