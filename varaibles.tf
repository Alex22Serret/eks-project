variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "practice-eks-cluster"
}

variable "spot_max_price" {
  description = "Maximum price for spot instances"
  type        = string
  default     = "0.02"
}
