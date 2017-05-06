require_relative 'twitter'
require_relative 'util'

# Twitterオブジェクトを準備
twitter = Twitter.new

# メニューを表示し、実行する機能を選択する
puts "(1) 片思いユーザをリムーブする"
puts "(2) 3ヶ月以上ツイートしていないユーザをリムーブする"
print "実行する機能を番号で選択してください: "
selected_menu = STDIN.gets.chomp.to_i

# 片思いユーザをリムーブする(最近フォローした30人は除く)
if selected_menu == 1
  only_follow_list = twitter.only_follow_list(30)
  only_follow_list.each do |f|
    twitter.remove(f)
    puts "【@#{twitter.id_to_name(f)} をリムーブしました】"
    sleep 2
  end
# 3ヶ月以上ツイートしていないユーザをリムーブ
elsif selected_menu == 2
  follow_list = twitter.follow_list
  date_from = DateTime.now << 3
  follow_list.each_with_index do |f, idx|
    sleep 2
    puts "#{idx + 1} / #{follow_list.count}: #{f}"
    next if twitter.verify_last_tweet_time(f, date_from, true)
    witter.remove(f)
    puts "【@#{twitter.id_to_name(f)} をリムーブしました】"
  end
end
