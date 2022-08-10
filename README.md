# README

# テーブル設計

## usersテーブル

| Column              | Type   | Options                 |
| ------------------- | ------ | ----------------------- |
| nickname            | string | null: false             |
| email               | string | null: false,unique:true |
| encrypted_password  | string | null: false             |
| kanji_last_name     | string | null: false             |
| kanji_first_name    | string | null: false             |
| hiragana_last_name  | string | null: false             |
| hiragana_first_name | string | null: false             |

### Association
- has_one :reserve

## reservesテーブル

| Column           | Type       | Options                      |
| ---------------- | ---------- | ---------------------------- |
| date             | date       | null: false                  |
| time_id          | integer    | null: false                  |
| people_number_id | integer    | null: false                  |
| tel_number       | string     | null: false                  |
| user             | references | null: false,foreign_key:true |

### Association
- belongs_to :user


## announcesテーブル

| Column  | Type   | Options     |
| ------- | ------ | ----------- |
| date    | date   | null: false |
| title   | string | null: false |
| content | text   | null: false |