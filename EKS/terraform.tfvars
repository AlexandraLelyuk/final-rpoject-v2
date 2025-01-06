region      = "us-east-1"
iam_profile = "default"

cluster_name = "sandra-cluster"

vpc_id      = "vpc-0fe31270afbc347a8"  
subnets_ids = [
  "subnet-04854c9f3de4fab00",  # us-east-1a
  "subnet-0b6b2bf1b5c983c9f",  # us-east-1b
  "subnet-0b130d891159e5fc6"   # us-east-1c
]

tags = {
  Environment = "dev"
  Project     = "sandra"
}

zone_name = "devops4.test-danit.com"
