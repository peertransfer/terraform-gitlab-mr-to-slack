module "gitlab_mr_to_slack" {
  source = "../../"
  
  slack_webhook_url = "https://hooks.slack.com/services/XXYYY/ASDSA/DSAD"
  labels_to_notify  = {
	  "SRE": "#mr-reminder-test1"
	  "TOOLS": "#mr-reminder-test2"
  }
}

output "webhook_endpoint" {
  value       = "${module.gitlab_mr_to_slack.webhook_endpoint}"
  description = "The public full URL of your lambda"
}
