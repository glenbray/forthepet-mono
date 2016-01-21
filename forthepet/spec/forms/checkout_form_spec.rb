require 'rails_helper'

describe CheckoutForm do

  let(:order) { Order.new }
  subject { CheckoutForm.new(order, User.new) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :billing_first_name }
  it { is_expected.to validate_presence_of :billing_last_name }
  it { is_expected.to validate_presence_of :billing_address1 }
  it { is_expected.to validate_presence_of :billing_suburb }
  it { is_expected.to validate_presence_of :billing_state }
  it { is_expected.to validate_presence_of :billing_postcode }
  it { is_expected.to validate_presence_of :shipping_first_name }
  it { is_expected.to validate_presence_of :shipping_last_name }
  it { is_expected.to validate_presence_of :shipping_address1 }
  it { is_expected.to validate_presence_of :shipping_suburb }
  it { is_expected.to validate_presence_of :shipping_state }
  it { is_expected.to validate_presence_of :shipping_postcode }

  describe '.initialize' do
    it 'updates user id if user is not nil' do
      user = FactoryGirl.create(:user)
      form = CheckoutForm.new(order, user)

      expect(form.model.user.id).to eq(user.id)
    end

    it 'updates user id to nil if user is nil' do
      form = CheckoutForm.new(order, nil)
      expect(form.model.user).to eq(nil)
    end

    it 'updates order email if user is not nil' do
      user = FactoryGirl.create(:user)
      form = CheckoutForm.new(order, user)
      expect(form.email).to eq(user.email)
    end

    it 'should not set order email to nil if user is nil' do
      form = CheckoutForm.new(Order.new(email: 'test@test.com'), nil)
      expect(form.email).to eq('test@test.com')
    end

    context 'valid user' do
      it 'prefills billing address if available' do
        user = FactoryGirl.create(:user)
        form = CheckoutForm.new(order, user)

        expect(form.billing_first_name).to eq(user.billing.first_name)
        expect(form.billing_last_name).to eq(user.billing.last_name)
        expect(form.billing_address1).to eq(user.billing.address1)
        expect(form.billing_suburb).to eq(user.billing.suburb)
        expect(form.billing_state).to eq(user.billing.state)
        expect(form.billing_postcode).to eq(user.billing.postcode)
      end

      it 'prefills shipping address if available' do
        user = FactoryGirl.create(:user)
        form = CheckoutForm.new(order, user)

        expect(form.shipping_first_name).to eq(user.shipping.first_name)
        expect(form.shipping_last_name).to eq(user.shipping.last_name)
        expect(form.shipping_address1).to eq(user.shipping.address1)
        expect(form.shipping_suburb).to eq(user.shipping.suburb)
        expect(form.shipping_state).to eq(user.shipping.state)
        expect(form.shipping_postcode).to eq(user.shipping.postcode)
      end
    end
  end

  describe '.billing_is_shipping' do
    it 'defaults to true' do
      expect(CheckoutForm.new(order, nil).billing_is_shipping).to be_truthy
    end

    it 'returns false if user has shipping address' do
      user = FactoryGirl.create(:user)
      expect(CheckoutForm.new(order, user).billing_is_shipping).to be_falsey
    end
  end

  describe '.validate' do
    it 'updates shipping address with billing details' do
      params = {
        email: 'john@snow.com',
        billing_first_name: "John",
        billing_last_name: "Snow",
        billing_company: "",
        billing_address1: "12 avalanche drive",
        billing_suburb: "Snowy Mountains",
        billing_state: "NSW",
        billing_postcode: "2250",
        billing_is_shipping: "1"
      }

      checkout_form = CheckoutForm.new(order, nil)
      expect(checkout_form.validate(params)).to be_truthy
    end
  end

  describe '.save_form' do
    it 'updates billing details to shipping details if billing_is_shipping' do
      user = FactoryGirl.create(:user)
      form = CheckoutForm.new(order, user)

      order_params = FactoryGirl.attributes_for(:billing_details)
      order_params.merge!(billing_is_shipping: true)
      expect(form.validate(order_params)).to be_truthy
    end
  end

end
