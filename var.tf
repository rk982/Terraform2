variable "AWS_SECRET_KEY"{}
variable "AWS_ACCESS_KEY"{}
variable "AWS_REGION" {
default = "us-east-1"
}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-053b0d53c279acc90"
        }
  
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"  
}