class BookingsController < ApplicationController
  before_action :set_service

  def new
    @booking = @service.bookings.new
  end

  def create
    @booking = @service.bookings.new(booking_params)
    if @booking.save
      redirect_to root_path, notice: "Booking request received!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_service
    @service = Service.find(params[:service_id])
  end

  def booking_params
    params.require(:booking).permit(:client_name, :client_email, :starts_at, :notes)
  end
end
