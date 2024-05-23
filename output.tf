output "swagger_ui_endpoint" {
  description = "Endpoint Swagger UI can be reached over"
  value       = "https://${aws_api_gateway_rest_api.this.id}.execute-api.ap-northeast-2.amazonaws.com/v1/api-docs/"
}
