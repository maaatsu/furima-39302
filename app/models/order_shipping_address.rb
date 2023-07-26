class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :telephone_number, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :telephone_number, length: { in: 10..11, message: 'is too short' },
                                 format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number (10-11 digits)' }
    validates :user_id
    validates :item_id
  end

  def save
    @order = Order.new(user_id: user_id, item_id: item_id)

    if @order.save
      ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
                             building_name: building_name, telephone_number: telephone_number, order_id: @order.id)
    else
      puts @order.errors.full_messages
    end
  end
end
