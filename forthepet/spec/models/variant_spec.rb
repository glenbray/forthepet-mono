require 'rails_helper'

describe Variant, type: :model do
  it { is_expected.to validate_presence_of(:weight) }
  it { is_expected.to validate_presence_of(:price) }

  it { is_expected.to belong_to(:product) }
  it { is_expected.to have_many(:cart_items) }

  describe "before save" do
    describe 'calculate_percentage_saved' do
      it 'calculates the correct percentage saved when saving' do
        variant = Variant.new(price: 10, original_price: 20, product_id: 1, is_master: true, weight: 10)
        variant.save
        expect(variant.percentage_saved).to eq(100)
      end

      it 'rounds when saving a decimal' do
        variant = Variant.new(price: 18.99, original_price: 27.74, product_id: 1, is_master: true, weight: 10)
        variant.save
        expect(variant.percentage_saved).to eq(46)
      end

      it 'saves percentage as 0 if original_price was not provided' do
        variant = Variant.new(price: 10, product_id: 1, is_master: true, weight: 10)
        variant.save
        expect(variant.percentage_saved).to eq(0)
      end
    end
  end
end
