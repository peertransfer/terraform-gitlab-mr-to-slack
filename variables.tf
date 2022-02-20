variable "name" {
  type        = string
  default     = "gitlab-to-slack"
  description = "Name of the stack"
}

variable "slack_webhook_url" {
  type        = string
  description = "Integration URL of Slack Webhook. Eg. https://hooks.slack.com/services/XX/YYYYY/ZZZZZZ"
}

variable "labels_to_notify" {
  type        = map(string)
  description = "A map of labels and corresponding slack channels to notify"
}

variable "custom_uri_path" {
  type        = string
  default     = "/"
  description = "Custom path for the API Gateway endpoint"
}

variable "gitlab_subscribe_events" {
  type        = string
  default     = "open,update"
  description = "Gitlab Merge Request events to subscribe to"
}

variable "lambda_description" {
  type        = string
  default     = "This lambda will receive http events from API gateway and will ship them to a Slack channel."
  description = "Description of the lambda functionality"
}

variable "api_gateway_description" {
  type        = string
  default     = "API that derives POST notifications from Gitlab to the associated lambda"
  description = "API Gateway description"
}

variable "api_gateway_cors_allow_headers" {
  type        = list(string)
  default     = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
  description = "API Gateway allowed headers"
}

variable "api_gateway_cors_allow_methods" {
  type        = list(string)
  default     = ["POST"]
  description = "API Gateway allowed headers"
}

variable "api_gateway_cors_allow_origins" {
  type        = list(string)
  default     = ["*"]
  description = "List of origins to allow traffic from."
}


