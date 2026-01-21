class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: %i[show edit update destroy]

  def index
    @services = current_user.services.order(created_at: :desc)
  end

  def show; end

  def new
    @service = current_user.services.new
  end

  def create
    @service = current_user.services.new(service_params)
    if @service.save
      redirect_to @service, notice: "Service created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: "Service updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to services_path, notice: "Service deleted."
  end

  private

  def set_service
    @service = current_user.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :description, :duration_minutes, :price_cents, :active)
  end
end
