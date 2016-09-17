class Admin::BrandsController < Admin::AdminController
  add_crumb 'Brands', '/admin/brands'

  def index
    @brands = Brand.all.order(:name)
  end

  def new
    @brand = Brand.new
    add_crumb 'New Brand'
  end

  def create
    brand = Brand.new(brand_params)

    if brand.save
      flash[:success] = 'Brand saved successfully'
    end

    redirect_to admin_brands_path
  end

  def edit
    @brand = Brand.find(params[:id])
    add_crumb 'Edit Brand'
  end

  def update
    brand = Brand.find(params[:id])

    if brand.update(brand_params)
      flash[:success] = 'Brand updated successfully'
    else
      flash[:danger] = 'Brand failed to update'
    end

    redirect_to admin_brands_path
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end
end
