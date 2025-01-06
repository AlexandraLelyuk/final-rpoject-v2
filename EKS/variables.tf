variable "cluster_name" {
  description = "Имя EKS кластера"
  type        = string
  default     = "sandra-cluster"
}

variable "vpc_id" {
  description = "ID VPC, в которой создаём EKS"
  type        = string
  default     = "vpc-0fe31270afbc347a8" 
}

variable "subnets_ids" {
  description = "Список подсетей (public/private) для EKS и рабочих нод"
  type        = list(string)
  default     = [
    "subnet-04854c9f3de4fab00", # us-east-1a
    "subnet-0b6b2bf1b5c983c9f", # us-east-1b
    "subnet-0b130d891159e5fc6"  # us-east-1c
  ]
}

variable "tags" {
  description = "Список/Map тегов для ресурсов"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "sandra"
  }
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "iam_profile" {
  description = "AWS profile для аутентификации"
  type        = string
  default     = "default"
}

variable "zone_name" {
  description = "devops4.test-danit.com"
  type        = string
  default     = "devops4.test-danit.com"
}
