class Order < ApplicationRecord

  belongs_to :user
  has_many :items, through: :ordered_items
  has_many :ordered_items
  enum status: { pending: 0, paid: 1, failed: 2}

end
