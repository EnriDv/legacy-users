variable "app_port" {
  default = 8000
}

variable "instance_type" {
  default = "t2.micro"
}

variable "iam_instance_profile" {
  type = string
}

variable "my_public_ip" {
  type = string
}