class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :order

  validates :shipping_address, presence: true
  validates :billing_address, presence: true
  validates :credit_card_number, length: { is: 16 }, numericality: { only_integer: true }
  validates :expiry_date, format: { with: /\A\d{2}\/\d{2}\z/ }
  validates :security_code, length: { is: 3 }, numericality: { only_integer: true }

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :addresses
    validates :phone_number, length: { minimum: 10, message: "is too short" }, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }
  
  end

end
