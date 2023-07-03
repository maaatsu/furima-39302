class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :image,               presence: true
  validates :name,                presence: true
  validates :description,         presence: true
  validates :category_id,         presence: true
  validates :status,              presence: true
  validates :shipping_fee_status, presence: true
  validates :prefecture,          presence: true
  validates :scheduled_delivery,  presence: true
  validates :price,               presence: true

  enum shipping_fee_status: { 着払い: 0, 送料込み: 1 }
end
