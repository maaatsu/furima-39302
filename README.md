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

* has_many :goods
* has_many :purchase_records

## goods テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| description         | text       | null: false                    |
| user                | references | null: false, foreign_key: true |
| category_id         | integer    | null: false                    |
| situation_id        | integer    | null: false                    |
| shipping_charge _id | integer    | null: false                    |
| region_of_origin_id | integer    | null: false                    |
| ship_date_id        | integer    | null: false                    |
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

| Column   | Type       | Options           |
| -------- | ---------- | ----------------- |
| user     | references | foreign_key: true |
| good     | references | foreign_key: true |

### Association

* belongs_to :user
* belongs_to :good
* has_one :shipping_addresses