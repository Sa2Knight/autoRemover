# Auto Remover
TwitterAPIを使用して、フォローしている以下の2つの方法でフォローしているユーザを整理するCLIツール
* 片思いのユーザをリムーブ(直近でフォローした30人は除外)
* 直近3ヶ月内で一度もツイートしていないユーザをリムーブ
# システム要件
以下の環境で動作確認済み

|要素|バージョン|
|----|--------|
|debian|8.6|
|ruby|2.2.2|
|gem|2.4.5|
|bundle|1.13.4|

# 前提
TwitterAPIを利用するための以下の4種のパラメータを用意済みであること
* API KEY
* API SECRET
* ACCESS KEY
* ACCESS SECRET

# インストール方法
GitHubからclone
> $ git clone git@github.com:Sa2Knight/autoRemover.git
ライブラリをインストール
> $ sudo bundle install --path vendor/bundle
ライブラリ内の一部ファイルを修正(最新のRestAPI仕様に対応していないため)
vendor/bundle/ruby/2.2.0/gems/twitter_oauth-0.4.94/lib/twitter_oauth

```ruby
def unfriend(id)
  post("/friendships/destroy.json", :user_id => id)
  #post("/friendships/destroy/#{id}.json")
end
```

# 実行方法
下記のように、各種APIキーをJSONで記述した、secret.jsonを作成する
```json
{
  "api_key": "hogehogehogehogehogehogehoge",
  "api_secret": "fugafugafugafugafugafugafuga",
  "access_token": "foofoofoofoofoofoofoofoofoofoofoo",
  "access_secret": "barbarbarbarbarbarbarbarbarbarbar",
}
```
以下のコマンドでスクリプトを実行

> $ bundle exec ruby main.rb

以下のように、画面の指示に従って番号を入力するとスクリプトが実行される

```bash
$ bundle exec ruby main.rb
(1) 片思いユーザをリムーブする
(2) 3ヶ月以上ツイートしていないユーザをリムーブする
実行する機能を番号で選択してください: 1
【************* をリムーブしました】
【************ をリムーブしました】
【********* をリムーブしました】
【******** をリムーブしました】
【*********** をリムーブしました】
【************** をリムーブしました】
【************ をリムーブしました】
$
```
