class Comment < ApplicationRecord

  belongs_to :item

  belongs_to :user

  # mount_uploader :image, ImageUploader

  validates :body, length: { minimum: 5 }, presence: true

  # paginates_per 3

end
