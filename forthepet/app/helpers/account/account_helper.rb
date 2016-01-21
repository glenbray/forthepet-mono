module Account::AccountHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def billing_url
    billing.new_record? ? account_billing_addresses_path : account_billing_address_path(billing.id)
  end

  def shipping_url
    shipping.new_record? ? account_shipping_addresses_path : account_shipping_address_path(shipping.id)
  end

  def shipping
    @user.shipping || Address.new
  end

  def billing
    @user.billing || Address.new
  end
end
