module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "v2.34.0"

  publish       = true
  function_name = var.name
  description   = var.lambda_description
  handler       = "app.lambda_handler"
  runtime       = "ruby2.7"

  environment_variables = {
    SLACK_WEBHOOK_URL           = var.slack_webhook_url
    SLACK_USERNAME              = var.slack_username
    GITLAB_MR_EVENTS_SUBSCRIBED = var.gitlab_subscribe_events
  }

  allowed_triggers = {
    APIGatewayAny = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*${var.custom_uri_path}"
    }
  }
  create_current_version_allowed_triggers = false

  source_path = "${path.module}/functions"

  depends_on = [
    local_file.config,
  ]
}

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "v1.5.1"

  create_api_domain_name = false

  name          = var.name
  description   = var.api_gateway_description
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = var.api_gateway_cors_allow_headers
    allow_methods = var.api_gateway_cors_allow_methods
    allow_origins = var.api_gateway_cors_allow_origins
  }

  integrations = {
    "POST ${var.custom_uri_path}" = {
      lambda_arn = module.lambda_function.lambda_function_arn
    }
  }
}

resource "local_file" "config" {
  content  = templatefile("${path.module}/templates/config.yml.tpl", { labels_to_notify = var.labels_to_notify })
  filename = "${path.module}/functions/config.yml"
}