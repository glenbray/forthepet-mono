class Admin::ProductController < Admin::AdminController
  add_crumb 'Products', '/admin/products'

  def index
    @q = Product.search(params[:q])
    @products = @q.result.includes(:master_variant, :variants, :photos, :supplier).where(is_active: true).order('created_at desc').page(params[:page])
  end

  def new
    @product = Product.new
    @product.master_variant = Variant.new
    add_crumb 'New Product'
  end

  def create
    @product = Product.new(create_product)

    if @product.save
      flash[:success] = 'Products created successfully'
      redirect_to edit_admin_product_path @product
    else
      flash[:danger] = 'Error saving product'
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    add_crumb 'Edit Product', "/admin/products/#{@product.id}/edit"
    add_crumb 'Details'
  end

  def update
    @product = Product.includes(:master_variant).find(params[:id])

    if @product.update(update_product)
      flash[:success] = 'Product updated successfully'
      redirect_to edit_admin_product_path @product
    else
      flash[:danger] = 'Unable to update product'
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    flash[:success] = 'Product deleted'
    redirect_to admin_product_index_path
  end

  def clone
    @product = Product.find(params[:product_id])

    clone = Product.new(@product.attributes)
    clone.name = "#{clone.name} (CLONE)"
    clone.id = nil

    if clone.save
      attributes = @product.master_variant.attributes.dup
      attributes.delete('id')
      clone.master_variant = Variant.new(attributes)
      clone.save
      flash[:success] = "#{@product.name} successfully cloned"
      redirect_to edit_admin_product_path(clone)
    else
      flash[:danger] = 'There was an error cloning this product'
      render :edit
    end
  end

  private

  def create_product
    params.require(:product).permit(:brand, :name,
                                    master_variant_attributes: [:price, :cost, :sku, :is_master, :free_postage])
  end

  def update_product
    params.require(:product).permit(:brand, :name, :description, :meta_description, :permalink, :meta_keywords,
                                    master_variant_attributes: [:id, :product_id, :sku, :price, :cost, :quantity, :weight, :height, :width, :depth, :free_postage])
  end
end
