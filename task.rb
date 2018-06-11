# coding: utf-8
$LOAD_PATH.push File.dirname( __FILE__ ) + '/lib'

require 'line_client'

exec_wday = ARGV[0].to_i

message = <<EOS
定期連絡です。練習の出欠に入力をお願いします。
https://chouseisan.com/s?h=0aa8981788814f73b92f7cd784624961
EOS

now = Time.now
return unless now.wday == exec_wday
client = LineClient.new
client.push(message)
