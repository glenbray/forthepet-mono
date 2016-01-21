class Admin::PropertyController < Admin::AdminController
  def index
    @property = Property.new
    @properties = Property.all
  end

  def create
    property = Property.new(create_property)

    if property.save
      flash[:success] = 'Successfully created Property'
    else
      flash[:danger] = 'Error Saving Property'
    end

    redirect_to admin_property_index_path
  end

  private

  def create_property
    params.require(:property).permit(:name, :presentation)
  end
end
