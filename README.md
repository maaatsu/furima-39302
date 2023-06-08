# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| name-full-width | string | null: false |
| name-kana       | string | null: false |
| date of birth   | string | null: false |

### Association

* has_many :goods
* has_many :shipping address
* has_one :purchase record

## goods テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| image            | string     | null: false                    |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| seller           | references | null: false, foreign_key: true |
| category         | string     | null: false                    |
| situation        | string     | null: false                    |
| shipping charges | string     | null: false                    |
| region of origin | string     | null: false                    |
| ship date        | string     | null: false                    |
| price            | string     | null: false                    |

### Association

* belongs_to :users
* has_one :shipping address
* has_one :purchase record

## shipping address テーブル

| Column           | Type       | Options     |
| ---------------- | ---------- | ------------|
| post code        | string     | null: false |
| prefectures      | string     | null: false |
| municipalities   | string     | null: false |
| address          | string     | null: false |
| building name    | string     | null: false |
| telephone number | string     | null: false |

### Association

* belongs_to :users
* belongs_to :goods
* has_one :purchase record

## purchase record テーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| buyer          | string     | null: false |
| purchase goods | string     | null: false |

### Association

* belongs_to :users
* belongs_to :goods
* belongs_to :shipping address