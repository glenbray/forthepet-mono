class CategoriesController < ApplicationController
  def show
    @primary_category = Category.find_by! slug: params[:primary_id]

    if params[:secondary_id].present?
      @secondary_category = @primary_category.descendants.find_by! slug: params[:secondary_id]
    end

    if params[:tertiary_id].present?
      @tertiary_category = @primary_category.descendants.find_by! slug: params[:tertiary_id]
      products = Product.by_category(@tertiary_category)
        .filter_by_brand(params[:brand_id]).page(params[:page])
      @products = ProductDecorator.decorate_collection(products)
      @brands = Brand.by_category(@tertiary_category)
    end
  end
end
