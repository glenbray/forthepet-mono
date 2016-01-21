2.times do
  Address.create do |a|
    a.first_name = 'Glen'
    a.last_name = 'Bray'
    a.address1 = '12/53-55 Henry Parry Dr'
    a.suburb = 'Gosford'
    a.state = 'NSW'
    a.postcode = 2250
    a.user_id = 1
    a.mobile = '0401839969'
  end
end
