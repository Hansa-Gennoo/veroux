class ProvidersController < ApplicationController
  def show
    @provider = User.find_by!(slug: params[:slug])
    @services = @provider.services.where(active: true).order(created_at: :desc)
  end
end
