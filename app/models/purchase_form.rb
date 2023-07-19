class PurchaseForm
  include ActiveModel::Model
  attr_accessor :item_id, :shipping_address, :billing_address, :credit_card_number, :expiry_date, :security_code, :user_id

  validates :shipping_address, presence: true
  validates :billing_address, presence: true
  validates :credit_card_number, length: { is: 16 }, numericality: { only_integer: true }
  validates :expiry_date, format: { with: /\A\d{2}\/\d{2}\z/ }
  validates :security_code, length: { is: 3 }, numericality: { only_integer: true }

  def save
    if valid?
      save_shipping_info
      save_purchase_info
      true
    else
      false
    end
  end

  private

  def save_shipping_info
    ShippingInfo.create(address: shipping_address)
  end

  def save_purchase_info
    Purchase.create(address: billing_address, credit_card_number: credit_card_number, expiry_date: expiry_date, security_code: security_code)
  end
end
