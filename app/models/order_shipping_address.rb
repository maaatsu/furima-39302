class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :order

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :city
    validates :address
    validates :telephone_number, length: { minimum: 10, message: "is too short" }, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }
  
  end

  def save
    order = Order.create(token: token)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture.id, city: city, address: address, building_name: building_name, telephone_number: telephone_number, order_id: order.id)
  end

end
