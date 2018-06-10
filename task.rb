# coding: utf-8
$LOAD_PATH.push File.dirname( __FILE__ ) + '/lib'

require 'line_client'

message = <<EOS
定期連絡です。以下の練習の出欠に入力をお願いします。
https://chouseisan.com/s?h=0aa8981788814f73b92f7cd784624961
EOS

now = Time.now
return unless now.monday?
client = LineClient.new
client.push(message)
