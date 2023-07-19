class ShippingAddress < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :addresses, presence: true
  validates :phone_number, presence: true, length: { minimum: 10, message: "is too short" }, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }

end
