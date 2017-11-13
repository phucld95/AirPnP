class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    @rooms = @user.rooms

    # display all the guest reviews to host (if rhis user is a host)
    @guest_reviews = Review.where(user_id: @user.id)
  end
end
