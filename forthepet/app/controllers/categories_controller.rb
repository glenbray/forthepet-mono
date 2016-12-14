class CategoriesController < ApplicationController
  def show
    @primary_category = Category.find_by! slug: params[:primary_id]

    if params[:secondary_id].present?
      @secondary_category = @primary_category.descendants.find_by! slug: params[:secondary_id]
    end

    if params[:tertiary_id].present?
      @tertiary_category = @primary_category.descendants.find_by! slug: params[:tertiary_id]
    end
  end
end
