if Rails.env.production?
  Braintree::Configuration.environment = :production
  Braintree::Configuration.merchant_id = 'xj9nyxsznbhjr69d'
  Braintree::Configuration.public_key = 'wpsw395kk7q2277n'
  Braintree::Configuration.private_key = 'e77f71377755d2b1bf26deba3149aa95'
else
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = 'xjqp5b4jn7zhw82b'
  Braintree::Configuration.public_key = '8t5pxq3gm88t3qhv'
  Braintree::Configuration.private_key = '74cfb67705b53c2e65d6e9e6cdb30e0f'
end
