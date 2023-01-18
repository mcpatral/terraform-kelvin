variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0b93ce03dcbcb10f6"
    us-east-2 = "ami-0cbea92f2377277a4"
    us-east-2 = "ami-0ff39345bd62c82a5"
  }
}
variable "PrivKey" {
  default = "mcpatral"
}
variable "Pubkey" {
  default = "mcpatral.pub"
}
variable "USERNAME" {
  default = "ubuntu"
}
variable "MYIP" {
  default = "183.83.39.120/32"
}
variable "rmquser" {
  default = "rabbit"
}
variable "rmqpass" {
  default = "Omobakelvin1"
}
variable "dbuser" {
  default = "admin"
}
variable "dbpass" {
  default = "admin123"
}
variable "dbname" {
  default = "accounts"
}
variable "instance_count" {
  default = "1"
}
variable "VPC_NAME" {
  default = "mcpatral-Vpc"
}
variable "ZONE1" {
  default = "us-east-1a"
}
variable "ZONE2" {
  default = "us-east-1b"
}
variable "ZONE3" {
  default = "us-east-1c"
}

variable "VpcCIDR" {
  default = "172.20.0.0/16"
}
variable "PubSub1CIDR" {
  default = "172.20.10.0/24"
}
variable "PubSub2CIDR" {
  default = "172.20.20.0/24"
}
variable "PubSub3CIDR" {
  default = "172.20.30.0/24"
}
variable "PrivSub1CIDR" {
  default = "172.20.40.0/24"
}
variable "PrivSub2CIDR" {
  default = "172.20.50.0/24"
}
variable "PrivSub3CIDR" {
  default = "172.20.60.0/24"
}