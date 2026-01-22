# app/controllers/dashboard/availabilities_controller.rb
class Dashboard::AvailabilitiesController < Dashboard::BaseController
  def show
    @availabilities = current_user.weekly_availabilities.order(:weekday)
  end

  def edit
    @availabilities = current_user.weekly_availabilities.order(:weekday)
  end

  def update
    params[:weekly_availabilities].each do |id, attrs|
      wa = current_user.weekly_availabilities.find(id)
      wa.update!(attrs.permit(:enabled, :start_time, :end_time))
    end
    redirect_to dashboard_availability_path, notice: "Availability updated."
  end
end
