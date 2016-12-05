class Admin::ProductCategoriesController < Admin::AdminController
  add_crumb 'Products', '/admin/products'

  def index
    @product = Product.find(params[:product_id])
    @categories = Category.all
    add_crumb 'Edit Product', "/admin/products/#{@product.id}/edit"
    add_crumb 'Categories'
  end

  def create
    @product = Product.find(params[:product_id])
    @product.update category_ids: params.dig(:product, :category_ids)
    flash[:success] = 'Categories succesfully updated'
    redirect_to admin_product_categories_path(@product)
  end
end
