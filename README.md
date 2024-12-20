# アプリケーション名
### おやこたび  
家族旅行をもっと楽しく！もっと学びに!

# アプリケーション概要
子供と一緒に、「次はどこ行こう？」「前はどこ行ったっけ？」など楽しみながら旅行の計画をたてて地理への興味を持たせる。簡単な準備イベントから主体性や楽しむ気持ちを育む。そんな家族旅行を子供の学びや成長につなげるアプリです。

# URL
http://13.112.242.59/

# テスト用アカウント
- Basic認証ID:admin
- Basic認証パスワード:2222
- メールアドレス：test@test.com
- パスワード：111111a

# 利用方法
1. ユーザー（おやこ）登録
2. 新しい旅行の作成
3. 準備イベントでの活用
4. 写真を保存してどんなところだったか思い出せる

# アプリケーションを作成した背景	
私は、家族と定期的にキャンプや旅行に出かけます。これまで、私や主人が計画や準備を全て担っていました。しかし、子供と一緒に取り組み、これらを彼らが学ぶ機会にしたいと考えていました。そこで、旅行の計画や準備と、子供の学習機会の両立ができるアプリケーションを開発致しました。

# 実装した機能についての画像やGIFおよびその説明

### トップページ
アプリの説明と特徴、使い方を説明しています。右上のボタンからログインやサインインができます。
<img width="1442" alt="スクリーンショット 2024-12-20 23 35 01" src="https://github.com/user-attachments/assets/ec33f689-95e4-45b6-bbce-abfa4fb4ca4a" />

### 旅行情報一覧ページ
右側の行った県に応じて、中央の白地図に色がついていきます。地理に興味を持たせながら、旅行計画を立てられます。
<img width="1497" alt="スクリーンショット 2024-12-02 22 13 01" src="https://github.com/user-attachments/assets/259bf693-d6f9-4e9f-a2aa-1b99990df103">

### 旅行情報の新規作成フォーム
日程と県を入力すれば新しい旅行情報が登録できます。そのほかに、自由記載のメモ欄、写真の添付、予算の保存が可能です。
<img width="1477" alt="スクリーンショット 2024-12-02 22 15 26" src="https://github.com/user-attachments/assets/50e6233d-bfd1-4cdb-badc-0eb056b9d337">

### 旅行情報詳細画面
登録した旅行情報のほかに、その旅行の準備イベントが表示されます。
<img width="1475" alt="スクリーンショット 2024-12-02 22 18 59" src="https://github.com/user-attachments/assets/9b949c7f-8060-45c5-a8de-82f3a59b9e53">

### 準備イベント1（自分の荷物を自分で用意しよう！）
アイテム名を入力すると、下の荷物リストに荷物が追加されます。追加・編集・削除全てが画面遷移することなく同じ画面で操作できます。
<img width="1484" alt="スクリーンショット 2024-12-02 22 20 53" src="https://github.com/user-attachments/assets/fb77f589-85e9-4f94-b5a9-9ac6eadf2d31">


# 実装予定の機能	
- 準備イベントの追加（おやつの買い出しに行こう！いくらかかるの？スケジュールを作成しよう！）
- 準備イベントの完了率を表示する機能
- 複数枚の画像保存機能（現在一枚のみ）

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
<img src="https://github.com/user-attachments/assets/c8b17547-5af5-43cd-9526-fafb28afa3b0" width="600">

# 開発環境	
- フロントエンド:HTML,CSS,JavaScript
- バックエンド:Ruby 3.2.0,Ruby on Rails 7.0.8
- インフラ: AWS EC2
- テスト:Rspec
- テキストエディタ:VScode
- タスク管理:Github

# ローカルでの動作方法	
```
 % git clone https://github.com/inayukaina/oyakotabi.git
 % cd クローンしたいディレクトリ
 % bundle install
 % rails db:create
 % rails db:migrate
```

# 工夫したポイント	
- 白地図に色がつく機能をトップページのメインにすること
- 画面遷移を少なく、一覧できること

# 改善点
- Viewファイルの改善：子供の興味関心を駆り立てるように修正を行う
- 準備イベントの追加
- 動的な装飾や機能の追加：準備イベントが完了した時に「旅行まで後少し！」と表示される等

# 制作時間	
2週間





