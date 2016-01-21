# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'jpg'

  version :cart do
    process resize_and_pad: [100, 100]
  end

  version :thumbnail do
    process resize_and_pad: [80, 80]
  end

  version :deal do
    process resize_and_pad: [483, 330]
  end

  version :deal_show do
    process resize_and_pad: [472, 433]
  end

  version :deal_small do
    process resize_and_pad: [55, 55]
  end

end
