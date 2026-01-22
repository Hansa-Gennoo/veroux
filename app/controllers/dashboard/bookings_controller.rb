module Dashboard
  class BookingsController < BaseController
    before_action :set_booking, only: %i[show confirm cancel]

    def index
      @bookings = Booking.joins(:service)
                         .where(services: { user_id: current_user.id })
                         .order(starts_at: :asc)
    end

    def show
      @booking =
        Booking
          .joins(:service)
          .where(services: { user_id: current_user.id })
          .find(params[:id])
    end

    def confirm
      @booking.update!(status: "confirmed")
      redirect_to dashboard_bookings_path, notice: "Booking confirmed."
    end

    def cancel
      @booking.update!(status: "cancelled")
      redirect_to dashboard_bookings_path, notice: "Booking cancelled."
    end

    private

    def set_booking
      @booking = Booking.joins(:service)
                        .where(services: { user_id: current_user.id })
                        .find(params[:id])
    end
  end
end
