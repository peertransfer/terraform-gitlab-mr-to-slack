output "webhook_endpoint" {
  value       = "${module.api_gateway.apigatewayv2_api_api_endpoint}${var.custom_uri_path}"
  description = "The public full URL of your lambda"
}
