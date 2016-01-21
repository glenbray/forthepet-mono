class Admin::ProductSupplierController < Admin::AdminController
  add_crumb 'Products', '/admin/products'

  def index
    @product = Product.includes(:category).find(params[:product_id])
    # @suppliers = Supplier.all
    add_crumb 'Edit Product', "/admin/products/#{@product.id}/edit"
    add_crumb 'Supplier'
  end

  def create
    product = Product.find(params[:product_id])
    product.supplier = Supplier.find(params[:product][:supplier_id])
    product.save
    flash[:success] = 'Supplier updated'
    redirect_to admin_product_suppliers_path(product.id)
  end
end
