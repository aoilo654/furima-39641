# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_date         | date    | null: false               |


### Association

has_many :items
has_many :orders
has_many :addresses

## items テーブル

| Column             | Type       | Options                        |
| -------------      | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| delivery_cost_id   | integer    | null: false                    |
| sender_id          | integer    | null: false                    |
| delivery_date_id   | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

has_one    :order
belongs_to :user
belongs_to :category
belongs_to :condition
belongs_to :delivery_cost
belongs_to :sender
belongs_to :delivery_date

## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| address       | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :item


## address テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

belongs_to :user
has_one    :order
belongs_to :prefecture