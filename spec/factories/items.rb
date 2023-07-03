FactoryBot.define do
  factory :item do

    image { Rack::Test::UploadedFile.new(Rails.root.join('public', 'images', 'test_image.png'), 'image/png') }
    name { "テスト商品" }
    description { "テスト商品の説明です" }
    category_id { "1" }
    status { "新品・未使用" }
    shipping_fee_status { "着払い" }
    prefecture { "東京都" }
    scheduled_delivery { "1~2日で発送" }
    price { 1000 }

  end
end
