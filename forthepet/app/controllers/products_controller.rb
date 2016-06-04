class ProductsController < ApplicationController
  def index
    @products = ProductDecorator.decorate_collection(Product.products)
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
    ProductDecorator.decorate_collection(Product.filter_categories(category))
  end
end
