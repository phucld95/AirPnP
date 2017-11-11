class GuestReviewsController < ApplicationController

  def create
    # 1. Check if reservation exist (room_id, host_id, host_id)

    # 2. Check if the current host already reviewed the guest in this reservation

    @reservation = Reservation.where(
      id: guest_review_params[:reservation_id],
      room_id: guest_review_params[:room_id]).first

    if !@reservation.nil? && @reservation.room.user_id == guest_review_params[:host_id].to_i
      @has_reviewed = GuestReview.where(
        reservation_id: @reservation.id,
        host_id: guest_review_params[:host_id]
      ).first
      if @has_reviewed.nil?
        # Allow to review


        #Bug rails khôgn hiểu được kế thừa trong model.
        byebug
        @guest_review = current_user.reviews.create guest_review_params
        flash[:success] = "Review created..."
      else
        # already reviewed
        flash[:success] = "You already reviewed this reservation"
      end
    else
      flash[:alert] = "Not found this reservation"
    end
    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @guest_review = Review.find_by id: params[:id]
    @guest_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Removed...")
  end

  private
  def guest_review_params
    params.require(:guest_review).permit(:comment, :star, :room_id, :reservation_id, :user_id)
  end
end
