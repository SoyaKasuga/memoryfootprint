# memoryfootprint
就職活動用に作成したポートフォリオです。


自分が体験した出来事を位置情報付きで投稿することができ、後から投稿を地図で確認することができます。

<img width="1440" alt="スクリーンショット 2020-06-25 20 46 00" src="https://user-images.githubusercontent.com/62055598/85716370-57087100-b727-11ea-9a2f-5ea7118e75c1.png">

# URL
https://memoryfootprint.com

# 使用技術
* Ruby2.5.1
* Rails
* Rspec
* sass,jquery
* Nginx
* puma
* AWS
  * EC2, RDS, S3, VPC, Route53, ALB, ACM
* Docker
* GitHub
* Circle CIを使用したCI/CDパイプライン
* Capistrano

# インフラ構成図
![Untitled Diagram (6)](https://user-images.githubusercontent.com/62055598/87865567-eb29c900-c9b1-11ea-8c78-6f29b04069cc.png)

# 機能一覧
* ユーザー登録、ログイン機能
* 投稿機能(画像投稿にcarrierwaveを使用)
* 投稿と位置情報の紐付け(geocoderとgmaps4railsを使用)
* ページネーション機能
* いいね機能(Ajax)
* いいね数のランキング機能(累計/月間)
* フォロー機能(Ajax)

# 課題
* テストコードが不足している
* コードのリファクタリングが十分でない
* 機能が少ない
