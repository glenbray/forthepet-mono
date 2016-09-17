require 'rails_helper'

describe Product, type: :model do

  it { is_expected.to have_many(:photos) }
  it { is_expected.to belong_to(:brand) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:supplier) }
  it { is_expected.to have_one(:master_variant) }
  it { is_expected.to have_many(:variants) }
  it { is_expected.to have_many(:features) }
  it { is_expected.to have_and_belong_to_many(:options) }

  describe '#master_variant?' do
    it 'returns true if no variants exist other than the master variant' do
      product = Product.new(master_variant: Variant.new(is_master: true))
      expect(product.master_variant?).to be_truthy
    end

    it 'returns false if variants exist' do
      product = Product.new(master_variant: Variant.new(is_master: true), variants: [Variant.new(is_master: false)])
      expect(product.master_variant?).to be_falsey
    end
  end

  describe '#photos?' do
    it 'returns true if it has photos' do
      product = Product.create
      allow(product).to receive(:photos) { [double(Photo)] }
      expect(product.photos?).to be_truthy
    end

    it 'returns false if there is no photos' do
      product = Product.create
      expect(product.photos?).to be_falsey
    end
  end

  describe '#update_options' do
    it 'updates product option' do
      product = FactoryGirl.create(:product)
      option = Option.create(name: 'Size')
      product.update_options(option.id)

      expect(product.options).to match_array([option])
    end

    it 'does not add an option if already exists' do
      product = FactoryGirl.create(:product)
      option = Option.create(name: 'Size')
      product.update_options(option.id)
      product.update_options(option.id)

      expect(product.options).to match_array([option])
    end

    it 'removes options if no options ids provided' do
      product = FactoryGirl.create(:product)
      option = Option.create(name: 'Size')
      product.update_options(option.id)
      product.update_options([])

      expect(product.options).to match_array([])
    end
  end

  describe '#highest_percentage_saved' do
    it 'returns percentage for master variant' do
      product = FactoryGirl.create(:product)
      expect(product.highest_percentage_saved).to eq(196)
    end

    it 'returns highest percentage if a product has many variants' do
      product = FactoryGirl.create(:product_with_variants)
      expect(product.highest_percentage_saved).to eq(62)
    end
  end

end
