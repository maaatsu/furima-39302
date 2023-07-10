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
| date_of_birth      | date   | null: false               |

### Association

* has_many :items
* has_many :purchase_records

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| image               | string     | null: false                    |
| name                | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| status              | integer    | null: false                    |
| shipping_fee_status | integer    | null: false                    |
| prefecture          | integer    | null: false                    |
| scheduled_delivery  | integer    | null: false                    |
| price               | integer    | null: false                    |

### Association

* belongs_to :user
* has_one :purchase_record

## shipping_addresses テーブル

| Column              | Type       | Options                        |
| --------------------| ---------- | ------------------------------ |
| post_code           | string     | null: false                    |
| region_of_origin_id | integer    | null: false                    |
| municipalities      | string     | null: false                    |
| address             | string     | null: false                    |
| building_name       | string     |                                |
| telephone_number    | string     | null: false                    |
| purchase_record     | references | null: false, foreign_key: true |

### Association

* belongs_to :purchase_record

## purchase_records テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| good     | references | null: false, foreign_key: true |

### Association

* belongs_to :user
* belongs_to :item
* has_one :shipping_address