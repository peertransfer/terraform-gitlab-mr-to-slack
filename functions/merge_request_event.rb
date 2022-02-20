require_relative 'environment'

class MergeRequestEvent
  def initialize(merge_request)
    @merge_request = merge_request
  end

  def action_not_subscribed?
    action = @merge_request
      .fetch('object_attributes')
      .fetch('action')
    
    ! configuration[:merge_request_events_subscribed].include?(action)
  end

  def has_no_labels
    @merge_request
      .fetch('labels')
      .empty?
  end

  def labels_to_notify
    labels = @merge_request
      .fetch('labels')

    labels_to_be_notified = []  
    labels.each do |label|
      labels_to_be_notified << label.fetch('title')
    end

    labels_to_be_notified
  end

  def repo_url
    @merge_request
      .fetch('project')
      .fetch('homepage')
  end

  def author
    @merge_request
      .fetch('user')
      .fetch('name')
  end

  def merge_request_url
    @merge_request
      .fetch('object_attributes')
      .fetch('url')
  end

  def merge_request_title
    @merge_request
      .fetch('object_attributes')
      .fetch('title')
  end

  def repo_name
    @merge_request
      .fetch('project')
      .fetch('name')
  end

  private

  def configuration
    Environment.configuration
  end
end