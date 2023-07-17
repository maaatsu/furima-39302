class Order < ApplicationRecord
  has_one :shipping_address
end
