class Admin::ProductFeaturesController < Admin::AdminController
  add_crumb 'Products', '/admin/products'

  def index
    @product = Product.find(params[:product_id])
    @feature = Feature.new(product_id: @product.id)
  end

  def create
    product = Product.find(params[:product_id])
    feature = Feature.new(feature_params)
    feature.product_id = product.id

    if feature.save
      flash[:success] = "#{feature.description} saved"
      redirect_to admin_product_features_url(product)
    else
      flash[:danger] = "error occured when saving feature"
      render :index
    end
  end

  def destroy
    feature = Feature.find(params[:id])
    feature.destroy
    flash[:danger] = "#{feature.description} has been deleted!"
    redirect_to admin_product_features_url(params[:product_id])
  end

  private

  def feature_params
    params.require(:feature).permit(:description)
  end
end
