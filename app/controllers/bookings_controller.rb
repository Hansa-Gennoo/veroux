class BookingsController < ApplicationController
  before_action :set_service

  def new
    @booking = @service.bookings.new
    @slots = SlotGenerator.new(
      service: @service,
      from_date: Date.current,
      to_date: Date.current + 14
    ).call
  end


  def create
    @booking = @service.bookings.new(booking_params)
    if @booking.save
      redirect_to booking_success_path, notice: "Booking request received!"

    else
      render :new, status: :unprocessable_entity
    end
  end

  def
    success
  end


  private

  def set_service
    @service = Service.find(params[:service_id])
  end

  def booking_params
    params.require(:booking).permit(:client_name, :client_email, :starts_at, :notes)
  end
end
