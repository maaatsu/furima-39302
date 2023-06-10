# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| date_of_birth      | string | null: false               |

### Association

* has_many :goods
* has_many :purchase record

## goods テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| description         | text       | null: false                    |
| user_id             | references | null: false, foreign_key: true |
| category_id         | integer    | null: false                    |
| situation_id        | integer    | null: false                    |
| shipping_charges_id | integer    | null: false                    |
| region_of_origin_id | integer    | null: false                    |
| ship_date_id        | integer    | null: false                    |
| price               | integer    | null: false                    |

### Association

* belongs_to :user
* has_one :purchase record

## shipping addresses テーブル

| Column              | Type   | Options     |
| ------------------- | ------ | ------------|
| post_code           | string | null: false |
| region_of_origin_id | string | null: false |
| municipalities      | string | null: false |
| address             | string | null: false |
| building_name       | string |             |
| telephone_number    | string | null: false |
| purchase_record_id  | string | null: false |

### Association

* belongs_to :purchase record

## purchase records テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| user_id  | string | null: false |
| goods_id | string | null: false |

### Association

* belongs_to :user
* belongs_to :good
* has_one :shipping addresses