variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "Nom du bucket S3 (globalement unique)"
  type        = string
}

variable "default_root_object" {
  description = "Objet racine CloudFront"
  type        = string
  default     = "README.md"
}
