class Product < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
    belongs_to :user, optional: true
end
