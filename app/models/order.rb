class Order < ApplicationRecord
  belongs_to :user
  has_one :shipping_address

  validates :token, presence: { message: "can't be blank" }

end
