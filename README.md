# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| shop_name          | string | null: false               |
| phone_number       | string | null: false               |
| fax_number         | string | null: false               |
| postal_code        | string | null: false               |
| prefecture         | string | null: false               |
| city               | string | null: false               |
| town               | string | null: false               |
| extended_address   | string | null: false               |


### Association

- has_many :products

## customers テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| phone_number       | string | null: false               |
| fax_number         | string | null: false               |
| postal_code        | string | null: false               |
| prefecture         | string | null: false               |
| city               | string | null: false               |
| town               | string | null: false               |
| extended_address   | string | null: false               |


### Association

- has_many :items
- has_many :products, through: :orders

## productsテーブル

| Column    | Type       | Options                       |
|-----------|------------|-------------------------------|
| name      | string     |null: false                    |
| variety   | string     |null: false                    |
| rank      | string     |null: false                    |
| weight    | integer    |null: false                    |
| price     | integer    |null: false                    |
| stock     | integer    |null: false                    |
| postage   | integer    |null: false                    |
| remark    | text       |null: false                    |
| suspended | boolean    |null: false, default: false    |
| user      | references |null: false, foreign_key: true |


### Association

- has_many :products, through: :orders

## ordersテーブル

| Column              | Type       | Options                       |
|---------------------|------------|-------------------------------|
| customer            | references |null: false, foreign_key: true |
| product             | references |null: false, foreign_key: true |
| quantity            | integer    |null: false                    |
| desired_delivery_on | date       |null: false                    |



### Association

- belongs_to :customer
- belongs_to :product
- has_one :reciever
- has_ine :shipments

## recievers テーブル

| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| email              | string     | null: false, unique: true     |
| encrypted_password | string     | null: false                   |
| last_name          | string     | null: false                   |
| first_name         | string     | null: false                   |
| last_name_kana     | string     | null: false                   |
| first_name_kana    | string     | null: false                   |
| phone_number       | string     | null: false                   |
| fax_number         | string     | null: false                   |
| postal_code        | string     | null: false                   |
| prefecture         | string     | null: false                   |
| city               | string     | null: false                   |
| town               | string     | null: false                   |
| extended_address   | string     | null: false                   |
| order              | references |null: false, foreign_key: true |


### Association

- belongs_to :order

## shipments テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| pick_up_on      | string     | null: false, unique: true      |
| arrival_on      | string     | null: false                    |
| invoice_number  | string     | null: false                    |
| remark          | string     | null: false                    |
| order           | references | null: false, foreign_key: true |


### Association

- belongs_to :order