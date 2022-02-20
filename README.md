# GitLab merge request notification to Slack Terraform module

This module creates an API Gateway and an AWS Lambda function that send notifications to Slack for each merge request event you want to be subscribed to. Current supported events include `open` and `update`.

Start by setting up an [incoming webhook integration](https://my.slack.com/services/new/incoming-webhook/) in your Slack workspace, you'll also need to configure a **Merge request event** [GitLab webhook integration](https://docs.gitlab.com/ee/user/project/integrations/webhooks.html) with the endpoint this module will provide after applying.

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

Then you can run `$ terraform output -raw webhook_endpoint` and paste that endpoint in your GitLab webhook integration URL.
