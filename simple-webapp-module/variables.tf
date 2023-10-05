variable "ami" {
  description = "The AMI for the instance"
  default     = "ami-053b0d53c279acc90"
  type        = string
}

variable "instances_number" {
  description = "Number of instances to lunch (default is 1)"
  default     = 1
  type        = number
}

variable "instance_type" {
  description = "Instance type to lunch (default it t2.micro)"
  default     = "t2.micro"
  type        = string
}
variable "region" {
  description = "Region of the infrastructure"
  default     = "us-east-1"
  type        = string
}

variable "availability_zone" {
  description = "Zone of the infrastructure"
  default     = "us-east-1a"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}