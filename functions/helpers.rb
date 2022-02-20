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
      def request
        uri = URI(Environment.configuration[:slack_hook])
        https = Net::HTTP.new(uri.host, uri.port)
        https.use_ssl = true
        
        request = Net::HTTP::Post.new(uri.path)
        request.body = {
          blocks: [
            {
              type: "section",
              text: {
                type: "mrkdwn",
                text: "[TOOLS-2538] Format properly all JSON files"
              }
            },
            {
              type: "context",
              elements: [
                {
                  type: "mrkdwn",
                  text: "pr description aldkaldqwl nqmwnd,qmsndqw,dnqwidas,"
                }
              ]
            }
          ]
        }.to_json
  
        response = https.request(request)
      end
    end
  end
end