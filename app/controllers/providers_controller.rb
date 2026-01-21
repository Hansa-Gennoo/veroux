class ProvidersController < ApplicationController
  def show
    @provider = User.find_by!(slug: params[:slug])
    @services = @provider.services.published.order(created_at: :desc)
  end
end
