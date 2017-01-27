#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-bison
#
/*
module "example" {
  source = "./example-module"
  command = "echo Goodby World"
}
*/

variable "aws_access_key" {
  type = "string"
  default = "AKIAIWAOXI4UNCUNCRQQ"
  }
variable "aws_secret_key" {
  type = "string"
  default = "SJPbIqNhZJU/1kFSZNpq+Jla2PyL2fHUH4d4pldl"
  }
variable "aws_region" {
  type = "string"
  default = "us-west-1"
  }
variable "num_webs" {
  default = "2"
  }


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count = "5"
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-7e50c21a"
  vpc_security_group_ids = ["sg-29ef374e"]

  tags {
    Identity    = "autodesk-bison"
    Name        = "web${count.index+1}/${var.num_webs}" 
    Environment	= "Production"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
  }

