# アプリケーション名
おやこたび  -家族旅行をもっと楽しく！もっと学びに!-

# アプリケーション概要
こどもと一緒に、「次はどこ行こう？」「前はどこ行ったっけ？」など楽しみながら旅行の計画をたてて地理への興味を持たせる。簡単な準備イベントから主体性や楽しむ気持ちを育む。そんな家族旅行を子供の学びや成長につなげるアプリです。

# URL

# テスト用アカウント

# 利用方法
１、ユーザー（おやこ）登録
２、新しい旅行の作成
３、準備イベントでの活用
４、写真を保存してどんなところだったか思い出せる

# アプリケーションを作成した背景	
私自身、月に一回キャンプに行ったり、年に一回は周遊の家族旅行をします。仕事家事育児と忙しい中、旅行の計画や準備は全て親がやってしまっていて、もっと簡単に任せられたら子供の成長に繋げられるのにと思っていました。そんな課題を解決するアプリです。

# 実装した機能についての画像やGIFおよびその説明

# 実装予定の機能	
準備イベントの追加（おやつの買い出しに行こう！いくらかかるの？スケジュールを作成しよう！）

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
| start_date         | date       | null: false                   |
| end_date           | date       | null: false                   |
| notes              | text       |                               |

### Association
- has_many :trip_prefectures
- has_many :prefectures, through: :trip_prefectures
- has_many :child_packing_items, dependent: :destroy
- has_many :snacks, dependent: :destroy
- has_one_attached :image  


## prefectures テーブル
| Column             | Type       | Options                             |
| ------------------ | ---------- | ----------------------------------- |
| name               | string     | null: false,index: { unique: true } |

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
Ruby on Rails
AWS EC2

# ローカルでの動作方法	

# 工夫したポイント	
・白地図に色がつく機能をトップページのメインにすること
・画面遷移を少なく、一覧できること

# 改善点	

# 制作時間	
２週間





