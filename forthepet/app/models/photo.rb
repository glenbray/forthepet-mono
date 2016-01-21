class Photo < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  validates :picture, presence: 'true'
end
