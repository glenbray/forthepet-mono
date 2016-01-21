unless Discount.find_by_description('Referral Credit')
  Discount.create do |d|
    d.description = 'Referral Credit'
    d.amount = 5.00
  end
end
