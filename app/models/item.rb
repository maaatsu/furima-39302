class Item < ApplicationRecord

  validates :image, presence: true
  validates :name, presence: true
  validates :category_id, presence: true
  validates :status, presence: true
  validates :shipping_fee, presence: true
  validates :region_of_origin_id, presence: true
  
end
