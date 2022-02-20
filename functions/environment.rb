require_relative 'helpers'
require 'yaml'

class Environment
  class << self
    def set?
      env_vars_to_check = [
        'GITLAB_MR_EVENTS_SUBSCRIBED',
        'SLACK_WEBHOOK_URL'
      ]
    
      envs_properly_set = true
      env_vars_to_check.each do |env|
        begin
          slack_hook = ENV.fetch(env)
        rescue KeyError
          Helpers.logger.error "Please ensure you set #{env} environment variable."
          envs_properly_set = false
        end
      end
    
      envs_properly_set
    end

    def configuration
      return @configuration if @configuration 
      
      @configuration = {
        :slack_hook => ENV.fetch('SLACK_WEBHOOK_URL'),
        :slack_username => ENV.fetch('SLACK_USERNAME', 'gitlab-to-slack default user'),
        :merge_request_events_subscribed => ENV.fetch('GITLAB_MR_EVENTS_SUBSCRIBED').split(','),
        :channels => YAML.safe_load(File.read('./config.yml')).fetch('labels')
      }
    end
  end
end