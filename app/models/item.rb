class Item < ApplicationRecord

  validates :image, presence: true
  validates :name, presence: true
  validates :category_id, presence: true
  validates :status, presence: true
  
end