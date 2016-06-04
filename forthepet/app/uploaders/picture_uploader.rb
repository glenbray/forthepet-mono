# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'jpg'

  version :cart do
    process resize_and_pad: [300, 250]
  end

  version :thumbnail do
    process resize_and_pad: [80, 80]
  end

  version :product do
    process resize_and_pad: [483, 330]
  end

  version :product_show do
    process resize_and_pad: [472, 433]
  end

  version :product_small do
    process resize_and_pad: [55, 55]
  end

end
