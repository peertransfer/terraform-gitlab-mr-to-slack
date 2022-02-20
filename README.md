# GitLab merge request notification to Slack Terraform module

This module creates an API Gateway and an AWS Lambda function that send notifications to Slack for each merge request event you want to be subscribed to.

GitLab will send a webhook notification to your lambda when you open/update a merge request. The lambda will then send a message to Slack channels depending on the labels applied to the merge request and the configuration specified when invoking the Terraform module.

### Requirements

- Set up an [incoming webhook integration](https://my.slack.com/services/new/incoming-webhook/) in your Slack workspace
- Create the [project labels](https://docs.gitlab.com/ee/user/project/labels.html) you want to apply to your merge requests


## Supported Features

- AWS Lambda runtime Ruby 2.7
- Create API Gateway
- Create AWS Lambda
- Configuration as Terraform code
- Potentially all features from lambda and apigatewayv2 community modules


## Usage

```hcl
module "gitlab_mr_to_slack" {
  source  = "https://github.com/Coolomina/terraform-gitlab-mr-to-slack"

  slack_webhook_url = "https://hooks.slack.com/services/XXX/YYY/ZZZ"
  labels_to_notify  = {
	  "SRE": "#sre-pr-reviews"
	  "DEV": "#dev-reviews"
	  "QA": "#qa-reviews"
  }
}
```


## GitLab configuration

After applying, you can run `$ terraform output -raw webhook_endpoint` and paste that endpoint in your GitLab webhook integration URL. You'll want to specify only Merge request events, as you'll be billed for each invocation of the lambda.


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | v1.5.1 |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | v2.34.0 |

## Resources

| Name | Type |
|------|------|
| [local_file.config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_gateway_cors_allow_headers"></a> [api\_gateway\_cors\_allow\_headers](#input\_api\_gateway\_cors\_allow\_headers) | API Gateway allowed headers | `list(string)` | <pre>[<br>  "content-type",<br>  "x-amz-date",<br>  "authorization",<br>  "x-api-key",<br>  "x-amz-security-token",<br>  "x-amz-user-agent"<br>]</pre> | no |
| <a name="input_api_gateway_cors_allow_methods"></a> [api\_gateway\_cors\_allow\_methods](#input\_api\_gateway\_cors\_allow\_methods) | API Gateway allowed headers | `list(string)` | <pre>[<br>  "POST"<br>]</pre> | no |
| <a name="input_api_gateway_cors_allow_origins"></a> [api\_gateway\_cors\_allow\_origins](#input\_api\_gateway\_cors\_allow\_origins) | List of origins to allow traffic from. | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_api_gateway_description"></a> [api\_gateway\_description](#input\_api\_gateway\_description) | API Gateway description | `string` | `"API that derives POST notifications from Gitlab to the associated lambda"` | no |
| <a name="input_custom_uri_path"></a> [custom\_uri\_path](#input\_custom\_uri\_path) | Custom path for the API Gateway endpoint | `string` | `"/"` | no |
| <a name="input_gitlab_subscribe_events"></a> [gitlab\_subscribe\_events](#input\_gitlab\_subscribe\_events) | Gitlab Merge Request events to subscribe to | `string` | `"open,update"` | no |
| <a name="input_labels_to_notify"></a> [labels\_to\_notify](#input\_labels\_to\_notify) | A map of labels and corresponding slack channels to notify | `map(string)` | n/a | yes |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | Description of the lambda functionality | `string` | `"This lambda will receive http events from API gateway and will ship them to a Slack channel."` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the stack | `string` | `"gitlab-to-slack"` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | Slack username to send notifications as | `string` | `"Gitlab MR webhook"` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | Integration URL of Slack Webhook. Eg. https://hooks.slack.com/services/XX/YYYYY/ZZZZZZ | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_webhook_endpoint"></a> [webhook\_endpoint](#output\_webhook\_endpoint) | The public full URL of your lambda |
