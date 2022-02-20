# gitlab-to-slack

curl -XPOST `terraform output -raw webhook_endpoint` -d @./events/gitlab_hook_with_label.json