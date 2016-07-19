class ProductsController < ApplicationController
  def index
    products = Product.products.page(params[:page])
    @products = ProductDecorator.decorate_collection(products)
  end

  def show
    @product = Product.single.find(params[:id]).decorate
    @cart_item = CartItem.new(quantity: 1)
  end

  def dog
    @products = search_products('Dog')
    render :index
  end

  def cat
    @products = search_products('Cat')
    render :index
  end

  def misc
    @products = search_products('Misc')
    render :index
  end

  private

  def search_products(category)
    products = Product.filter_categories(category).page(params[:page])
    ProductDecorator.decorate_collection(products)
  end
end
