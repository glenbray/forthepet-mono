# encoding: utf-8

class CategoryUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :small do
    process resize_to_fill: [300, 250]
  end

  version :thumbnail do
    process resize_to_fill: [80, 80]
  end

  def default_url(*args)
    case version_name
    when :thumbnail
      'http://placehold.it/80x80'
    else
      'http://placehold.it/300x250'
    end
  end

end
