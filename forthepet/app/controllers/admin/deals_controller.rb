class Admin::DealsController < Admin::AdminController
  add_crumb 'Deals', '/admin/deals'

  def index
    @q = Deal.search(params[:q])
    deals = @q.result.order('ends_on desc').page(params[:page])
    @deals = DealDecorator.decorate_collection(deals)
  end

  def new
    @deal = Deal.new(deal_defaults)

    if params[:product_id]
      product = Product.find(params[:product_id]).decorate
      @deal.product = product
      @deal.name = product.name unless @deal.name.present?
      @deal.description = product.short_description

      if product.has_variants?
        product.variants.each do |v|
          @deal.deal_prices.build(variant_id: v.id, price: v.price)
        end
      else
        @deal.deal_prices.build(variant_id: product.master_variant.id, price: 0)
      end
    end

    add_crumb 'New Deal'
  end

  def create
    deal = Deal.new(deal_params)

    if deal.save
      flash[:success] = 'Deal created'
      redirect_to edit_admin_deal_path(deal)
    else
      flash[:danger] = 'Error creating deal'
      render :new
    end
  end

  def edit
    @deal = Deal.friendly.find(params[:id]).decorate
    @deal_prices = @deal.deal_prices.joins(:variant).order('variants.position asc')
    add_crumb 'Edit Deal', "/admin/deals/#{params[:id]}/edit"
    add_crumb 'Details'
  end

  def update
    deal = Deal.friendly.find(params[:id])

    if deal.update(deal_params)
      flash[:success] = 'Deal updated'
    else
      flash[:danger] = 'Unable to update deal'
    end

    redirect_to edit_admin_deal_path(deal)
  end

  def destroy
    deal = Deal.friendly.find(params[:id])
    deal.destroy
    redirect_to admin_deals_path
  end

  def attach
    @deal = Deal.includes(:product).friendly.find(params[:deal_id])
    @search = Product.active.search(params[:q])
    @products = @search.result
    add_crumb 'Edit Deal', "/admin/deals/#{params[:id]}/edit"
    add_crumb 'Attach Product'
  end

  def attach_product
    deal = Deal.friendly.find(params[:deal_id])
    product = Product.find(params[:id])
    deal.product = product

    if deal.save
      flash[:success] = "Sucessfully attached #{product.name} to #{deal.name}"
    else
      flash[:danger] = 'Unable to attach product'
    end

    redirect_to edit_admin_deal_path(deal)
  end

  def detach_product
    deal = Deal.friendly.find(params[:deal_id])
    deal.product = nil

    if deal.save
      flash[:success] = 'Successfully deleted product attachment!'
    else
      flash[:danger] = 'Unable to delete product attachment!'
    end

    redirect_to edit_admin_deal_path(deal)
  end

  private

  def deal_params
    params.require(:deal).permit(:name, :available_on, :ends_on, :description, :price, :max_quantity, :product_id,
                                 deal_prices_attributes: [:id, :price, :variant_id, :deal_id])
  end

  def deal_defaults
    { max_quantity: 10, available_on: Time.now, ends_on: (2.weeks.from_now + 1.day).midnight }
  end
end
