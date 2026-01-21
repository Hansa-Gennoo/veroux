# app/controllers/dashboard/availabilities_controller.rb
class Dashboard::AvailabilitiesController < Dashboard::BaseController
    def show; end
    def edit; end

    def update
      # Step 3 will implement saving availability
      redirect_to dashboard_availability_path, notice: "Availability saved (stub)."
    end

end
