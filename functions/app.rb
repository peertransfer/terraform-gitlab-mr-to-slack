require 'json'
require 'base64'
require_relative 'environment'
require_relative 'helpers'

def lambda_handler(event:, context:)
  return unless Environment.set?

  body = JSON.parse(Base64.decode64(event['body']))
  event['body'] = body

  Helpers::Slack.request

  {
    statusCode: 200,
    body: {
      msg: "OK"
    }.to_json
  }
end
