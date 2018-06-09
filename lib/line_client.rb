require 'line/bot'

# Client class for LINE
class LineClient
  attr_reader :client

  class InvalidRequest < StandardError; end

  def initialize
    @client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
    @push_id = ENV['PUSH_TO_ID']
  end

  # @param request [Request] request
  # @return [Line::Bot::Event] reveived event
  def receive_event(request)
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless @client.validate_signature(body, signature)
      raise InvalidRequest, 'Bad Request'
    end
    @client.parse_events_from(body)
  end

  # reply message
  # @param reply_token [String] token for identify reply to
  # @param message [String] message to reply
  def reply(reply_token, message)
    client.reply_message(reply_token, text_message(message))
  end

  # push  message
  # @param message [String] message to push
  def push(message)
    client.push_message(@push_id, text_message(message))
  end

  private

  # messaging structure
  # @param message [String]
  # @return [Hash] messaging structure
  def text_message(message)
    {
      "type" => "text",
      "text" => message
    }
  end
end
