class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: { message: "can't be blank" }
  validates :name, presence: { message: "can't be blank" }
  validates :description, presence: { message: "can't be blank" }
  validates :category_id, presence: { message: "can't be blank" }
  validates :status, presence: { message: "can't be blank" }
  validates :shipping_fee_status, presence: { message: "can't be blank" }
  validates :prefecture, presence: { message: "can't be blank" }
  validates :scheduled_delivery, presence: { message: "can't be blank" }
  validates :price, presence: { message: "can't be blank" },
                    numericality: { only_integer: true,
                                  greater_than_or_equal_to: 300,
                                  less_than_or_equal_to: 9_999_999,
                                  message: "is out of setting range" }
    validates :price, presence: true,
                      format: { with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters" }
                                
end
