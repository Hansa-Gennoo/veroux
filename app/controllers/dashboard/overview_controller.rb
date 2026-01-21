module Dashboard
  class OverviewController < BaseController
    def index
      @services = current_user.services.order(created_at: :desc).limit(5)
      @bookings = Booking.joins(:service)
                         .where(services: { user_id: current_user.id })
                         .order(starts_at: :asc)
                         .limit(10)
    end
  end
end
