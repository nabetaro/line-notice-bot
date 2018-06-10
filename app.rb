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
      logger.info '############################'
      logger.info event['source'].inspect
      logger.info '############################'
    end
  }
  "OK"
end
