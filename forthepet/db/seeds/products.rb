dog = Category.find_by_name('Dog')
cat = Category.find_by_name('Cat')

product = Product.create do |p|
  p.brand = '???'
  p.name = 'Pet Safe No Bark Collars'
  p.description = 'Pet Safe No bark collars. Spray Bark Control. Anti barking collars'
  p.meta_description = 'Pet Safe No bark Collars Spray Bark Control Anti Barking Collars'
  p.permalink = 'no-bark-collars'
  p.slug = 'no-bark-collars'
  p.category = dog
  p.is_active = true
end

product = Product.create do |p|
  p.brand = '???'
  p.name = '50 Pigs Ears'
  p.description = 'Pig ears.'
  p.permalink = '50-pigs-ears'
  p.slug = '50-pigs-ears'
  p.category = dog
  p.is_active = true
end

product = Product.create do |p|
  p.brand = 'Ipetz'
  p.name = 'Ipetz Pet Cooling Mat. Small'
  p.description = 'Pet Cooling Mat.'
  p.permalink = 'pet-cooling-mat-small'
  p.slug = 'pet-cooling-mat-small'
  p.is_active = true
end

product = Product.create do |p|
  p.brand = 'Ipetz'
  p.name = 'Ipetz Pet Cooling Mat. Medium'
  p.description = 'Pet Cooling Mat.'
  p.permalink = 'pet-cooling-mat-medium'
  p.slug = 'pet-cooling-mat-medium'
  p.is_active = true
end

product = Product.create do |p|
  p.brand = 'Ipetz'
  p.name = 'Ipetz Pet Cooling Mat. Large'
  p.description = 'Pet Cooling Mat.'
  p.permalink = 'pet-cooling-mat-large'
  p.slug = 'pet-cooling-mat-large'
  p.is_active = true
end

product = Product.create do |p|
  p.brand = 'Jerhigh'
  p.name = 'Jerhigh Chicken Sampler 800g net'
  p.description = 'Jerhigh Chicken Sampler 800g net.'
  p.permalink = 'jerhigh-chicken-sampler-800g-net'
  p.slug = 'jerhigh-chicken-sampler-800g-net'
  p.category = dog
  p.is_active = true
end

product = Product.create do |p|
  p.brand = 'Wahl'
  p.name = 'Wahl ShowPro Pet Clipper Kit'
  p.description = 'Wahl ShowPro Pet Clipper Kit.'
  p.permalink = 'wahl-showpro-pet-clipper-kit'
  p.slug = 'wahl-showpro-pet-clipper-kit'
  p.category = dog
  p.is_active = true
end
