class Item < ApplicationRecord

  validates :image, presence: true
  validates :name, presence: true
  
end
