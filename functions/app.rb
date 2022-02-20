require 'json'
require 'base64'
require_relative 'environment'
require_relative 'helpers'
require_relative 'merge_request_event'

def lambda_handler(event:, context:)
  return unless Environment.set?

  body = JSON.parse(Base64.decode64(event['body']))

  gitlab_event = MergeRequestEvent.new(body)
  return if gitlab_event.has_no_labels
  return if gitlab_event.action_not_subscribed?

  Helpers::Slack.request(gitlab_event)

  {
    statusCode: 200,
    body: {
      msg: "OK"
    }.to_json
  }
end
