class ProductsController < ApplicationController
  def index
    products = Product.products.filter_by_brand(params[:brand_id]).page(params[:page])
    @products = ProductDecorator.decorate_collection(products)
    load_brands
  end

  def show
    @product = Product.single.find(params[:id]).decorate
    @cart_item = CartItem.new(quantity: 1)
  end

  def dog
    @products = search_products('Dog')
    load_brands('Dog')
    render :index
  end

  def cat
    @products = search_products('Cat')
    load_brands('Cat')
    render :index
  end

  def misc
    @products = search_products('Misc')
    load_brands('Misc')
    render :index
  end

  private

  def search_products(category)
    products = Product.filter_categories(category).filter_by_brand(params[:brand_id]).page(params[:page])
    ProductDecorator.decorate_collection(products)
  end

  def load_brands(category = nil)
    products = category ? Product.filter_categories(category) : Product
    brand_ids = products.products.pluck(:brand_id).uniq.compact

    @brands = Brand.where(id: brand_ids).order(:name)
  end
end
