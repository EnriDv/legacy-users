variable "app_port" {
  default = 8000
}
variable "instance_type" {
  default = "t2.micro"
}
variable "iam_profile" {
  description = "Nombre del perfil IAM de AWS Academy"
  default     = "LabRole"
}