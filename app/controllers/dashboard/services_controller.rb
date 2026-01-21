module Dashboard
  class ServicesController < Dashboard::BaseController
    def index
      @services = current_user.services
    end

    def new
      @service = current_user.services.new
    end
  end
end
