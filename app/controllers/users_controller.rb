class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    @rooms = @user.rooms

    # display all the guest reviews to host (if rhis user is a host)
    @guest_reviews = Review.where(type: GuestReview.name, host_id: @user.id)

    # display all the host reviews to guest (if this user is a guest)
    @host_reviews = Review.where(type: HostReview.name, guest_id: @user.id)
  end
end
