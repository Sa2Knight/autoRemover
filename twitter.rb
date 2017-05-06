require 'twitter_oauth'
class Twitter

  # initialize - インスタンスを生成する
  #---------------------------------------------------------------------
  def initialize

    # APIのアクセスキーを取得
    twitter_api = Util.read_secret
    key = twitter_api['api_key']
    secret = twitter_api['api_secret']
    a_token = nil
    a_secret = nil
    # アクセストークンを取得
    if twitter_api['access_token'] && twitter_api['access_secret']
      a_token = twitter_api['access_token']
      a_secret = twitter_api['access_secret']
    end
    # TwitterAPIの利用開始
    @twitter = TwitterOAuth::Client.new(
        :consumer_key => key,
        :consumer_secret => secret,
        :token => a_token,
        :secret => a_secret
    )
    @authed = @twitter && @twitter.info['screen_name'] ? true : false
  end

  # request_token - Twitter認証用のURLを生成する
  #--------------------------------------------------------------------
  def request_token(callback)
    request_token = @twitter.request_token(:oauth_callback => callback)
    return request_token
  end

  # set_access_token - Twitter連携用のアクセストークンを保存
  #--------------------------------------------------------------------
  def set_access_token(req_token , req_secret , verifier)
    @token = @twitter.authorize(req_token , req_secret , :oauth_verifier => verifier)
    Util.set_user_info(@token.token , {
      :secret => @token.secret,
      :username => @twitter.info['screen_name'],
      :icon => @twitter.info['profile_image_url'],
      :created_at => Time.now.strftime('%Y-%m-%d %H:%M:%S')
    })
    @authed = true
  end

  # usertoken - ユーザのトークンを取得する
  #--------------------------------------------------------------------
  def usertoken
    @authed and return @token.token
  end

  def tweet(text)
    @twitter.update(text)
  end

end
