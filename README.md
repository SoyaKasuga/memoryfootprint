# memoryfootprint
就職活動用に作成したポートフォリオです。
自分が体験した出来事を位置情報付きで投稿することができ、後から自分の投稿を地図で確認することができます。

![Uploading スクリーンショット 2020-06-25 20.46.00.png…]()

# URL
https://memoryfootprint.com

# 使用技術
*Ruby2.5.1
*Rails
*Rspec
*sass,jquery
*Nginx
*puma
*AWS
  *EC2, RDS, S3, VPC, Route53, ALB, ACM
*Docker
*GitHub

# 構成図

# 機能一覧
*ユーザー登録、ログイン機能
*投稿機能(画像投稿にcarrierwaveを使用)
*投稿と位置情報の紐付け(geocoderとgmaps4railsを使用)
*ページネーション機能
*いいね機能(Ajax)
*いいね数のランキング機能(累計/月間)
*フォロー機能(Ajax)

# 課題
*テストコードが不足している
*機能が少ない
