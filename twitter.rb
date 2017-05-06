require 'date'
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

    # フォロー一覧
    @follow_list = nil

    # フォロワー一覧
    @follower_list = nil
  end

  # follow_list フォローしているユーザ一のID一覧を取得
  #---------------------------------------------------------------------
  def follow_list
    @follow_list or @twitter.friends_ids['ids']
  end

  # follower_list フォロワーのID一覧を取得
  #---------------------------------------------------------------------
  def follower_list
    @follower_list or @twitter.followers_ids['ids']
  end

  # only_follow_list 片思いフォローしているユーザのID一覧を取得
  #---------------------------------------------------------------------
  def only_follow_list
    self.follow_list - self.follower_list
  end

  # get_last_tweet_by_userid - ユーザIDを指定して、そのユーザの直近のツイートを取得
  #---------------------------------------------------------------------
  def get_last_tweet_by_userid(userid)
    @twitter.user_timeline(:user_id => userid, :count => 1).first
  end

  # verify_last_tweet_time - 指定したユーザが指定した日時以降にツイートをしていることを検証する
  #---------------------------------------------------------------------
  def verify_last_tweet_time(user_id, date_from, verbose = false)
    last_tweet = self.get_last_tweet_by_userid(user_id)
    last_tweet_date = DateTime.parse(last_tweet['created_at'])
    is_used = last_tweet_date > date_from
    if verbose && ! is_used
      puts "------------------------------------"
      puts last_tweet["user"]["screen_name"]
      puts "最終ツイート日時 #{last_tweet_date.strftime("%Y/%m/%d %H:%M")}"
    end
    return is_used
  end

end
