class Order < ApplicationRecord
  belongs_to :user
  has_one    :shipping_address
  belongs_to :item
end
