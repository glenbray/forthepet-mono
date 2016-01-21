Deal.create do |d|
  d.name = 'Pet Safe No Bark Collars $100 Off!'
  d.available_on = Date.today
  d.ends_on = 14.days.from_now
  d.price = 99.00
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'no-bark-collars-100-off'
  d.product_id = 1
end

Deal.create do |d|
  d.name = 'Pigs Ears, 40% off!'
  d.available_on = Date.today
  d.ends_on = 7.days.from_now
  d.price = 79.95
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'pigs-ears-40-off'
  d.product_id = 2
end

Deal.create do |d|
  d.name = 'Small Ipetz Pet Cooling Mat. $10 off! (30cm x 40cm)'
  d.available_on = Date.today
  d.ends_on = 14.days.from_now
  d.price = 19.95
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'small-ipetz-pet-cooling-mat-10-off'
  d.product_id = 3
end

Deal.create do |d|
  d.name = 'Medium Ipetz Pet Cooling Mat. $12 off! (60cm x 44cm)'
  d.available_on = Date.today
  d.ends_on = 8.days.from_now
  d.price = 27.50
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'medium-ipetz-pet-cooling-mat-12-off'
  d.product_id = 4
end

Deal.create do |d|
  d.name = 'Large Ipetz Pet Cooling Mat. $20 off! (90cm x 90cm)'
  d.available_on = Date.today
  d.ends_on = 14.days.from_now
  d.price = 59.95
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'large-ipetz-pet-cooling-mat-20-off'
  d.product_id = 5
end

Deal.create do |d|
  d.name = 'Jerhigh Chicken Sampler 800g net. 2 for $29.95.'
  d.available_on = Date.today
  d.ends_on = 14.days.from_now
  d.price = 29.95
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'jerhigh-chicken-sampler-800g-2-for-29-95'
  d.product_id = 6
end

Deal.create do |d|
  d.name = 'Wahl Showpro Pet Clipper Kit. $30 off!'
  d.available_on = Date.today
  d.ends_on = 14.days.from_now
  d.price = 79.95
  d.is_active = true
  d.max_quantity = 100
  d.slug = 'wahl-showpro-pet-clipper-kit-30-off'
  d.product_id = 7
end
