require_relative 'environment'

class Helpers
  class << self
    def logger
      return @logger if @logger

      @logger = Logger.new(STDOUT)
    end
  end
  
  class Slack
    class << self
      def request(gitlab_event)
        uri = URI(Environment.configuration[:slack_hook])
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Post.new(uri.path)
        labels_to_notify = gitlab_event.labels_to_notify
        labels_to_notify.each do |label|
          request.body = {
            channel: Environment.configuration[:channels][label],
            blocks: prepare_blocks(gitlab_event)
          }.to_json
    
          https.request(request)
        end

      end

      private

      def prepare_blocks(gitlab_event)
        text = ":monkey-dev: <#{gitlab_event.merge_request_url}|#{gitlab_event.merge_request_title}> by *#{gitlab_event.author}*"
        [
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: text
            }
          },
          {
            type: "context",
            elements: [
              {
                type: "mrkdwn",
                text: "in repository *#{gitlab_event.repo_name}*"
              }
            ]
          }
        ]
      end
    end
  end
end