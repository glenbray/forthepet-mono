class CheckoutForm < Reform::Form
  model :order

  attr_accessor :billing_is_shipping

  property :email
  property :billing_first_name
  property :billing_last_name
  property :billing_company
  property :billing_address1
  property :billing_suburb
  property :billing_state
  property :billing_address2
  property :billing_mobile
  property :billing_phone
  property :billing_postcode
  property :shipping_first_name
  property :shipping_last_name
  property :shipping_address1
  property :shipping_suburb
  property :shipping_state
  property :shipping_postcode
  property :shipping_company
  property :shipping_address2
  property :shipping_mobile
  property :shipping_phone
  property :special_instructions

  validates :email, presence: true
  validates :billing_first_name, presence: true
  validates :billing_last_name, presence: true
  validates :billing_address1, presence: true
  validates :billing_suburb, presence: true
  validates :billing_state, presence: true
  validates :billing_postcode, presence: true
  validates :shipping_first_name, presence: true
  validates :shipping_last_name, presence: true
  validates :shipping_address1, presence: true
  validates :shipping_suburb, presence: true
  validates :shipping_state, presence: true
  validates :shipping_postcode, presence: true

  def initialize(order, user)
    order.user_id = user&.id
    order.email ||= user&.email
    user_address(order, user)

    super(order)
  end

  def validate(params)
    other_params = params.dup

    if other_params[:billing_is_shipping] == '1'
      other_params.merge!(shipping_first_name:  other_params[:billing_first_name],
                          shipping_last_name:   other_params[:billing_last_name],
                          shipping_address1:    other_params[:billing_address1],
                          shipping_address2:    other_params[:billing_address2],
                          shipping_suburb:      other_params[:billing_suburb],
                          shipping_state:       other_params[:billing_state],
                          shipping_postcode:    other_params[:billing_postcode],
                          shipping_mobile:      other_params[:billing_mobile],
                          shipping_phone:       other_params[:billing_phone])
    end

    super(other_params)
  end

  def billing_is_shipping
    @billing_is_shipping.nil? ? true : @billing_is_shipping
  end

  private

  def user_address(order, user)
    return if user.nil?

    if user.billing
      user_billing_address(order, user)
    end

    if user.shipping
      user_shipping_address(order, user)
    end
  end

  def user_billing_address(order, user)
    order.billing_first_name = user.billing.first_name
    order.billing_last_name = user.billing.last_name
    order.billing_address1 = user.billing.address1
    order.billing_address2 = user.billing.address2
    order.billing_suburb = user.billing.suburb
    order.billing_state = user.billing.state
    order.billing_postcode = user.billing.postcode
    order.billing_mobile = user.billing.mobile
    order.billing_phone = user.billing.phone
  end

  def user_shipping_address(order, user)
    self.billing_is_shipping = false
    order.shipping_first_name = user.shipping.first_name
    order.shipping_last_name = user.shipping.last_name
    order.shipping_address1 = user.shipping.address1
    order.shipping_address2 = user.shipping.address2
    order.shipping_suburb = user.shipping.suburb
    order.shipping_state = user.shipping.state
    order.shipping_postcode = user.shipping.postcode
    order.shipping_mobile = user.shipping.mobile
    order.shipping_phone = user.shipping.phone
  end
end
