class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :order, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :city
    validates :address
    validates :telephone_number, length: { minimum: 10, message: "is too short" }, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }
  
  end

  def save
    @order = Order.create(user_id: user_id, item_id: item_id)
  
    if @order.persisted?
      ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, telephone_number: telephone_number, order_id: @order.id)
    else
      puts @order.errors.full_messages
    end
  end
  
  
end
