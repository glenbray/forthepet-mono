class Admin::VariantController < Admin::AdminController
  add_crumb 'Products', "/admin/products"

  def index
    load_product
    add_crumb 'Edit Product', "/admin/products/#{@product.id}/edit"
    add_crumb 'Variants'
  end

  def create
    @product = Product.includes(:variants).find(params[:product_id])
    variant = @product.variants.build(variant_params.merge(is_master: 'false'))

    if variant.save
      flash[:success] = "Variant created"
      redirect_to admin_product_variants_path(@product)
    else
      @product.reload
      flash[:danger] = "Error creating variant"
      load_product
      render :index
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @variant = Variant.find(params[:id])
  end

  def update
    product = Product.find(params[:product_id])
    variant = Variant.find(params[:id])

    if variant.update(update_variant_params)
      flash[:success] = "Variant successfully updated"
      redirect_to admin_product_variants_path(product)
    else
      flash[:danger] = "Error updating variant"
      render :edit
    end
  end

  def destroy
    variant = Variant.find(params[:id])

    if variant.delete
      flash[:success] = "Variant deleted"
      redirect_to admin_product_variants_path(params[:product_id])
    else
      flash[:danger] = "Error deleting variant"
      load_product
      render :index
    end
  end

  def sort
    params[:variant].each_with_index do |id, index|
      Variant.find(id).update(position: index + 1)
    end
    render nothing: true
  end

  private

  def load_product
    @product ||= Product.includes(:master_variant, variants: [:option_values]).find(params[:product_id])
    @variant = Variant.new
  end

  def variant_params
    params.require(:variant).permit(:sku, :price, :original_price, :cost, :quantity, :is_master, :height,
                                    :width, :depth, :weight, :free_postage, option_value_ids: [])
  end

  def update_variant_params
    variant_params.tap{ |h| h.delete(:is_master) }
  end

end
