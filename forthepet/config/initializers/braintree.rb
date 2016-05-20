if Rails.env.production?
  Braintree::Configuration.environment = :production
  Braintree::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID']
  Braintree::Configuration.public_key = ENV['BRAINTREE_PUBLIC_KEY']
  Braintree::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY']
else
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = 'xjqp5b4jn7zhw82b'
  Braintree::Configuration.public_key = '8t5pxq3gm88t3qhv'
  Braintree::Configuration.private_key = '74cfb67705b53c2e65d6e9e6cdb30e0f'
end
