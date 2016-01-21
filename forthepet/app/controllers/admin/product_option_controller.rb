class Admin::ProductOptionController < Admin::AdminController
  add_crumb 'Products', '/admin/products'

  def index
    @product = Product.find(params[:product_id])
    add_crumb 'Edit Product', "/admin/products/#{@product.id}/edit"
    add_crumb 'Options'
  end

  def update
    @product = Product.includes(:options).find(params[:product_id])
    @product.options.delete
    options = Option.where(id: params[:product][:option_ids])
    @product.options = options

    flash[:success] = 'Options saved successfully'
    redirect_to admin_product_options_path(@product)
  end
end
