# アプリケーション名
おやこたび
# アプリケーション概要

# URL

# テスト用アカウント

# 利用方法	

# アプリケーションを作成した背景	

# 実装した機能についての画像やGIFおよびその説明

# 実装予定の機能	

# データベース設計	
## users テーブル
| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| name               | string     | null: false               |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false               |

### Association
- has_many :trips


##  trips テーブル
| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| user_id            | references | null: false, foreign_key:true |
| budget_total       | integer    | default: 0	                  |
| start_date         | date       |                               |
| end_date           | date       |                               |
| notes              | text       |                               |

### Association
- has_many :trip_prefectures
- has_many :prefectures, through: :trip_prefectures
- has_many :child_packing_items, dependent: :destroy
- has_many :snacks, dependent: :destroy


## prefectures テーブル
| Column             | Type       | Options                   |
| ------------------ | ---------- | ------------------------- |
| name               | string     | null: false, unique: true |
| region             | string     |                           |あとから地域ごと実装

### Association
- has_many :trip_prefectures
- has_many :trips, through: :trip_prefectures


## trip_prefectures テーブル (中間テーブル)
| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| trip_id            | references | null: false, foreign_key:true |
| prefecture_id      | references | null: false, foreign_key:true |

### Association
- belongs_to :trip
- belongs_to :prefecture

## child_packing_items テーブル
| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| trip_id            | references | null: false, foreign_key:true |
| name               | string     | null: false                   |
| quantity           | integer    | default: 1                    |
| is_event_completed | boolean    | default: false                |

### Association
- belongs_to :trip


## snacks テーブル
| Column             | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| trip_id            | references | null: false, foreign_key:true |
| name               | string     | null: false                   |
| snack_budget       | integer    | default: 0                    |
| is_event_completed | boolean    | default: false                |

### Association
- belongs_to :trip


# 画面遷移図	

# 開発環境	

# ローカルでの動作方法	

# 工夫したポイント	

# 改善点	

# 制作時間	





