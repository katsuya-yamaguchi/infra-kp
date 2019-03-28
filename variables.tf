####################
# Region
####################
variable "region" {
  type    = "string"
  default = "us-east-2"
}

####################
# VPC
####################
variable "vpc" {
  type = "map"
  default = {
    dev.cidr     = "10.10.0.0/16"
    prd.cidr     = "20.10.0.0/16"
  }
}

####################
# Subnet
####################
variable "subnet_public-a" {
  type = "map"
  default = {
    dev.cidr     = "10.10.10.0/24"
    prd.cidr     = "20.10.10.0/24"
  }
}

variable "subnet_public-b" {
  type = "map"
  default = {
    dev.cidr     = "10.10.20.0/24"
    prd.cidr     = "20.10.20.0/24"
  }
}

variable "subnet_private-a" {
  type = "map"
  default = {
    dev.cidr     = "10.10.30.0/24"
    prd.cidr     = "20.10.30.0/24"
  }
}

variable "subnet_private-b" {
  type = "map"
  default = {
    dev.cidr     = "10.10.40.0/24"
    prd.cidr     = "20.10.40.0/24"
  }
}

variable "subnet_database-a" {
  type = "map"
  default = {
    dev.cidr     = "10.10.50.0/24"
    prd.cidr     = "20.10.50.0/24"
  }
}

variable "subnet_database-b" {
  type = "map"
  default = {
    dev.cidr     = "10.10.60.0/24"
    prd.cidr     = "20.10.60.0/24"
  }
}

####################
# EC2
####################
variable "instance_type" { type = "map"
  default = {
    dev.instance_type = "t2.nano"
    prd.instance_type = "t2.nano"
  }
}

####################
# SSH Key
####################
variable "ssh_key_path" {
  default = {
    dev.path = "./key-pair/web-01.pub"
    pub.path = "./key-pair/web-01.pub"
  }
}
