class Deals::ProductDealsController < ApplicationController
  def dog
    @deals = search_deals('Dog')
    render '/deals/index'
  end

  def cat
    @deals = search_deals('Cat')
    render '/deals/index'
  end

  def misc
    @deals = search_deals('Misc')
    render '/deals/index'
  end

  private

  def search_deals(category)
    DealDecorator.decorate_collection(Deal.active_product_deals(category))
  end

end
