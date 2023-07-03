class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,                null: false, foreign_key: true
      t.string     :image,               null: false
      t.string     :name,                null: false
      t.text       :description,         null: false
      t.integer    :category_id,         null: false
      t.integer    :status,              null: false
      t.integer    :shipping_fee_status, null: false
      t.integer    :prefecture,          null: false
      t.integer    :scheduled_delivery,  null: false
      t.integer    :price,               null: false
    end
  end
end
