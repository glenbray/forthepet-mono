require 'rails_helper'

RSpec.describe DealPrice, type: :model do

  let(:product) { FactoryGirl.create(:product) }
  let(:variant) { product.master_variant }
  let(:deal_price) { DealPrice.new(variant: variant, price: 10) }

  describe '#before_save' do
    it 'exectes calculate_percentage_saved method' do
      expect(deal_price).to receive(:calculate_percentage_saved)
      deal_price.save
    end

    it 'calculates percentage saved' do
      discounted_price = (variant.price - deal_price.price)
      expected_percentage = discounted_price / variant.price * 100
      deal_price.save

      expect(deal_price.percentage_saved).to eq(expected_percentage)
    end
  end

end
