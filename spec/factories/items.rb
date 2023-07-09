FactoryBot.define do
  factory :item do
    image { Rack::Test::UploadedFile.new(Rails.root.join('public', 'images', 'test_image.png'), 'image/png') }
    name { 'テスト商品' }
    description { 'テスト商品の説明です' }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 1000 }
  end
end
