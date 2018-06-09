require 'sinatra'
require 'line_client'

def client
  @client ||= LineClient.new
end

error LineClient::InvalidRequest do
  'Bad Request'
end

post '/callback' do
  events = client.receive_event(request)

  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        client.reply(event['replyToken'], event["message"]["text"])
      end
    end
  }
  "OK"
end
