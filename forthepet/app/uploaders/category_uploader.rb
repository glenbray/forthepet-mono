# encoding: utf-8

class CategoryUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :small do
    process resize_and_fill: [300, 250]
  end

  version :thumbnail do
    process resize_and_fill: [80, 80]
  end

  def default_url(*args)
    'http://placehold.it/350x250?text='
  end

end
