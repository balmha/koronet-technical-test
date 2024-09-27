variable "aws_region" {
  description = "The AWS region to deploy the EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "koronet-eks-cluster"
}