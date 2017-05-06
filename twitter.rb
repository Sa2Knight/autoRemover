require 'twitter_oauth'
class Twitter

  # initialize - インスタンスを生成する
  #---------------------------------------------------------------------
  def initialize

    # APIのアクセスキーを取得
    twitter_api = Util.read_secret
    key = twitter_api['api_key']
    secret = twitter_api['api_secret']
    a_token = twitter_api['access_token']
    a_secret = twitter_api['access_secret']

    # TwitterAPIの利用開始
    @twitter = TwitterOAuth::Client.new(
        :consumer_key => key,
        :consumer_secret => secret,
        :token => a_token,
        :secret => a_secret
    )
  end

  # follow_list フォローしているユーザ一のID一覧を取得
  #---------------------------------------------------------------------
  def follow_list
    @twitter.friends_ids['ids']
  end

  # follower_list フォロワーのID一覧を取得
  #---------------------------------------------------------------------
  def follower_list
    @twitter.followers_ids['ids']
  end

  # only_follow_list 片思いフォローしているユーザのID一覧を取得
  #---------------------------------------------------------------------
  def only_follow_list
    self.follow_list - self.follower_list
  end

end
