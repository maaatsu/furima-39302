class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :items
  
  validates :image,               presence: true
  validates :name,                presence: true
  validates :description,         presence: true
  validates :category_id,         presence: true
  validates :status,              presence: true
  validates :shipping_fee_status, presence: true
  validates :prefecture,          presence: true
  validates :scheduled_delivery,  presence: true
  validates :price,               presence: true

  enum shipping_charge_id: { unpaid: 0, free_shipping: 1 }
end
