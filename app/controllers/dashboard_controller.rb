class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @services = current_user.services.order(created_at: :desc)
    @bookings = Booking.joins(:service)
                      .where(services: { user_id: current_user.id })
                      .order(starts_at: :asc)
  end
end
