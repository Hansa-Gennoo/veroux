class BookingsStatusController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking

  def confirm
    @booking.update!(status: "confirmed")
    redirect_to dashboard_path, notice: "Booking confirmed."
  end

  def cancel
    @booking.update!(status: "cancelled")
    redirect_to dashboard_path, notice: "Booking cancelled."
  end

  private

  def set_booking
    @booking = Booking.joins(:service)
                      .where(services: { user_id: current_user.id })
                      .find(params[:id])
  end
end
