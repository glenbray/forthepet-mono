class Admin::ProductWizardController < Admin::AdminController
  include Wicked::Wizard

  steps :category, :supplier, :product, :image, :final

  def show
    case step
    when :supplier
      search_supplier
    when :product
      @brands = Brand.all.order(:name)
      session_product_associations
      product_form
    when :image
      @photo = session_product.photos.build
    end

    render_wizard
  end

  def update
    @product = session_product

    case step
    when :category
      @product.update_attributes category_ids: params.dig(:product, :category_ids)
      render_wizard @product
    when :supplier
      @product.update_attributes(supplier_id: params[:supplier_id])
      render_wizard @product
    when :product
      session_product_associations

      if product_form.validate(params[:product])
        product_form.model.slug = nil
        render_wizard @product_form
      else
        @brands = Brand.all.order(:name)
        render_wizard
      end
    when :image
      @photo = session_product.photos.build(image_params)
      @photo.save
      render_wizard
    when :final
      @product.update_attributes(is_active: true)
      session[:product_id] = nil
      redirect_to edit_admin_product_path(@product)
    end
  end

  private

  def search_supplier
    @q = Supplier.search(params[:q])
    @suppliers = @q.result(distinct: true)
  end

  def product_form
    @product_form ||= Admin::CreateProductForm.new(session_product)
  end

  def session_product_associations
    session_product.build_master_variant if session_product.master_variant.nil?
    session_product
  end

  def session_product
    @product ||= begin
      if session[:product_id].blank?
        product = create_product
        session[:product_id] = product.id
        product
      else
        begin
          Product.find(session[:product_id])
        rescue ActiveRecord::RecordNotFound
          product = create_product
          session[:product_id] = product.id
          product
        end
      end
    end
  end

  def create_product
    Product.create(is_active: false)
  end

  def image_params
    params.require(:photo).permit(:alt_text, :picture, :description)
  end

end
