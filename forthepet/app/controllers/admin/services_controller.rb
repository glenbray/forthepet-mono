class Admin::ServicesController < Admin::AdminController
  def index
    @service = Service.new
  end

  def create
  end

  private

  def service_params
    params.require(:service).permit(:name, :location)
  end
end
