class DealPrice < ActiveRecord::Base
  before_save :calculate_percentage_saved

  belongs_to :deal
  belongs_to :variant

  private

  def calculate_percentage_saved
    amount_saved = variant.price - price
    self.percentage_saved = amount_saved / variant.price * 100
  end

end
