variable "project_name" {
  description = "The name of the project"
  default     = "testing-tf"
  type        = string
}

variable "instance_type" {
  description = "The EC2 Instance type"
  default     = "t2.micro"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The main CIDR for the VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "public_subnets_count" {
  description = "Number of public subnets"
  default     = 3
  type        = number
  validation {
    condition     = var.public_subnets_count >= 3
    error_message = "Number of public subnets needs to be greater or equal than 3"
  }
}

variable "private_subnets_count" {
  description = "Number of private subnets"
  default     = 3
  type        = number
  validation {
    condition     = var.private_subnets_count >= 3
    error_message = "Number of private subnets needs to be greater or equal than 3"
  }
}

# variable "public_subnet_cidr_1" {
#   description = "The CIDR for the public subnet 1"
#   default     = "10.0.0.0/24"
#   type        = string
# }
# variable "public_subnet_cidr_2" {
#   description = "The CIDR for the public subnet 2"
#   default     = "10.0.1.0/24"
#   type        = string
# }
# variable "public_subnet_cidr_3" {
#   description = "The CIDR for the public subnet 2"
#   default     = "10.0.2.0/24"
#   type        = string
# }

# variable "private_subnet_cidr_1" {
#   description = "The CIDR for the private subnet 1"
#   default     = "10.0.3.0/24"
#   type        = string
# }

# variable "private_subnet_cidr_2" {
#   description = "The CIDR for the private subnet 2"
#   default     = "10.0.4.0/24"
#   type        = string
# }

# variable "private_subnet_cidr_3" {
#   description = "The CIDR for the private subnet 3"
#   default     = "10.0.5.0/24"
#   type        = string
# }
