class PagesController < ApplicationController
  def home
    @rooms = Room.where(active: true).limit(3)
    @cities = City.all
  end

  def search
    # STEP 1
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    # STEP 2
    if session[:loc_search] && session[:loc_search] != ""
      @rooms_address = Room.where(active: true).near(session[:loc_search], 5, order: "distance")
    else
      @rooms_address = Room.where(active: true).all
    end

    #STEP 3
    @search = @rooms_address.ransack(params[:q])
    @room = @search.result

    if @room.present?
      @arrRooms = @room.to_a
      if (params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty?)
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])

        @rooms.each do |room|
          not_avaiable = room.reservations.where(
            "(? <= start_date AND end_date <= ?)
            OR (? <= end_date AND end_date <= ?)
            OR (start_date < ? AND ? < end_date)
            AND status = ?",
            start_date, end_date,
            start_date, end_date,
            start_date, end_date,
            1
          ).limit(1)

          if not_avaiable.length > 0
            @arrRooms.delete room
          end
        end
      end
    else
      flash[:notice] = t ".not_found_any_rooms"
    end
  end
end
