variable "AWS_REGION" {
  default = "eu-west-1"
}

variable "AWS_ACCESS_KEY" {
  type = string
  default = ""
}

variable "AWS_SECRET_KEY" {
  type= string
  default = ""
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/root/.ssh/id_rsa"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "/root/.ssh/id_rsa.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    eu-west-1 = "ami-6e28b517"
    eu-west-1 = "ami-192a9460"
    eu-west-1 = "ami-5f76b626"
  }
}

