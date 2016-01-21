require 'rails_helper'

describe Deal, type: :model do

  it { should have_many(:order_items) }

  describe '#fine_prints_with_defaults' do
    let(:deal) { Deal.create(name: 'fine print deal', available_on: Time.now, ends_on: 2.days.from_now) }

    it 'returns default fine prints' do
      fine_print = FactoryGirl.create(:fine_print)
      expect(deal.fine_prints_with_defaults).to match_array([fine_print])
    end

    it 'does not save fine prints that are not default' do
      fp1 = FactoryGirl.create(:fine_print)
      fp2 = FactoryGirl.create(:non_default_fine_print)
      deal.fine_prints << fp2
      expect(deal.fine_prints_with_defaults).to match_array([fp1, fp2])
    end
  end

  describe '#active_product_deals' do
    it 'returns active deals' do
      deal = FactoryGirl.create(:deal)
      expect(Deal.active_product_deals('All')).to match_array([deal])
    end

    it 'does not return deals that have ended' do
      FactoryGirl.create(:deal)
      deal = FactoryGirl.create(:ended_deal)
      expect(Deal.active_product_deals('Dog')).not_to match_array([deal])
    end

    it 'returns for a specific category' do
      deal = FactoryGirl.create(:cat_deal)
      FactoryGirl.create(:dog_deal)
      expect(Deal.active_product_deals('Cat')).to match_array([deal])
    end
  end

  describe '#active?' do
    it 'returns false if no product is attached' do
      deal = Deal.new(available_on: Time.now, ends_on: 2.days.from_now)
      expect(deal.active?).to be_falsy
    end

    context '#ends_on' do
      it 'returns true if ends_on is greater than Time.now' do
        expect(Deal.new.active?).to be_falsy
      end

      it 'returns false if Time.now is less than ends_on' do
        deal = Deal.new(available_on: Time.now, ends_on: 2.days.from_now, product: Product.new)
        expect(deal.active?).to be_truthy
      end

      it 'returns false if ends on is Time.now' do
        deal = Deal.new(available_on: Time.now, ends_on: Time.now, product: Product.new)
        expect(deal.active?).to be_falsy
      end
    end

    context '#available_on' do
      it 'returns true if available_on is now' do
        deal = Deal.new(available_on: Time.now, ends_on: 2.days.from_now, product: Product.new)
        expect(deal.active?).to be_truthy
      end

      it 'returns true if available on is less than current time' do
        deal = Deal.new(available_on: 1.day.ago, ends_on: 2.days.from_now, product: Product.new)
        expect(deal.active?).to be_truthy
      end

      it 'returns false if available on is greater than current time' do
        deal = Deal.new(available_on: 1.day.from_now, ends_on: 2.days.from_now, product: Product.new)
        expect(deal.active?).to be_falsy
      end
    end
  end

  describe '#product_name' do
    it 'returns attached product name' do
      deal = Deal.new(product: Product.new(name: 'test'))
      expect(deal.product_name).to eq('test')
    end
  end

  describe '#highest_percentage_saved' do
    it 'returns percentage for master_variant' do
      deal = FactoryGirl.create(:deal)
      expect(deal.highest_percentage_saved).to eq(34)
    end

    it 'returns highest percentage if there are many deals' do
      deal = FactoryGirl.create(:deal_with_variants)
      expect(deal.highest_percentage_saved).to eq(20)
    end
  end

end
