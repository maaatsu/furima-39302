FactoryBot.define do
  factory :order_shipping_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '函館市' }
    address { '1-1' }
    building_name { '函館ハイツ' }
    telephone_number { '09012345678' }
  end
end
