# アプリケーション名
PEARSALES
# アプリケーションの概要
梨を販売したい出店者はホームページ内で自分のアカウントを作成して、梨をWeb上で販売することができる。また梨を購買したい人は自分のアカウントを作成することによって出店されている梨を購買することができる。
# URL

# テスト用アカウント
出店者用のメールアドレス:  
出店者用のパスワード:  
購入者用のメールアドレス：  
購入者用のパスワード:  
# 利用方法
## 商品の出品
1.トップページのヘッダーからユーザーの新規登録を行う。  
2.ヘッダーのマイページ一番下の商品の新規出品ボタンから商品内容（商品名、品種、ランク、商品重量、送料、値段、コメント、在庫、出品中or停止中のチェックボタン）を入力して出品する。
## 商品の購入
1.トップページのヘッダーからユーザーの新規登録を行う。  
2.上部のメニューバーから出店一覧を選び、購入したいユーザーの店をクリックする。  
3.商品一覧から購入したい品種のタブを選択し、商品の一覧ボタンを押す。  
4.詳細ページにて数量を選択してカートに入れるボタンを押す。  
5.ヘッダー部分のマイカートを選択して欲しい商品が全部あるか確認する。変更したい場合は、カート内のアイテムの数量を変更して更新ボタンを選択する。もしくは削除ボタンを押して商品をカートから削除する。  
6.確認後はカート内の購入予約ボタンを押して予約フォームに必要事項を入力()した後に、確認画面へボタンを押す。  
7.確認画面の情報が正しい場合、購入決定ボタンを押して購入する。
# アプリケーションを作成した背景
実家やその周りの地域では梨の直売が盛んで、夏の最盛期には沢山のお客様で賑わっている。売上の中でも贈答用の箱売りの梨が一番の売上になるが、お得意様などの一部の方が買っていくのみである。インターネット販売を行っているのは一部の有名店や自分のホームページを持っている人のみで、店頭で注文を受け付けている人が自分の実家を含めて多いと感じた。このような人たちが気軽に梨をインターネット販売できるようなアプリがあると便利だと感じたため、梨販売のアプリケーションの開発を行うことにした。
# 洗い出した要件
# 実装した機能についての画像やGIF、およびその説明
# 実装予定の機能
# データベース設計
# 画面遷移図
# 開発環境
# ローカルでの動作方法
# 工夫したポイント


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
| shop_name          | string | null: false, unique: true |
| phone_number       | string | null: false               |
| fax_number         | string |                           |
| postal_code        | string | null: false               |
| prefecture         | string | null: false               |
| city               | string | null: false               |
| town               | string | null: false               |
| extended_address   | string |                           |


### Association

- has_many :products

## customers テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| phone_number       | string | null: false               |
| fax_number         | string |                           |
| postal_code        | string | null: false               |
| prefecture         | string | null: false               |
| city               | string | null: false               |
| town               | string | null: false               |
| extended_address   | string |                           |


### Association

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

- belongs_to :user
- has_many :customers, through: :orders

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