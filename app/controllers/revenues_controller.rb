class RevenuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.current_week_revenue current_user
    # create hash with key is date and value is total. Sum up all total if same date
    @this_week_revenue = @reservations.map {|r| { r.updated_at.strftime("%Y-%m-%d") => r.total}}
                                      .inject({}) {|a, b| a.merge(b){|_, x, y| x + y}}

    # Display all day. Creat a hash
    @this_week_revenue = Date.today().all_week.map {|date| [date.strftime("%a"), @this_week_revenue[date.strftime("%Y-%m-%d")] || 0]}
  end
end
