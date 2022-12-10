
terraform {
  backend "local" {}
}

# provider間の違いを吸収する
provider "aws" {
  region = "ap-northeast-1"
  access_key = "hoge"
  secret_key = "piyo"

  s3_use_path_style = true
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true

  endpoints {
    ec2 = "http://localhost:4566"
  }
}

# 変数
# variable "example_instance_type" {
#   default = "t3.micro"
# }

# 外から上書き不可なローカル変数
locals {
  example_instance_type = "t3.micro"
}

# データソース
data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name = "state"
    values = ["available"]
  }
}

resource "aws_security_group" "example_ec2" {
  name = "example-ec2"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# EC2
resource "aws_instance" "example" {
  # ami = "ami-test"
  ami = data.aws_ami.recent_amazon_linux_2.image_id
  # instance_type = var.example_instance_type
  instance_type = local.example_instance_type
  vpc_security_group_ids = [aws_security_group.example_ec2.id]

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}

# 出力値
output "example_instance_id" {
  value = aws_instance.example.public_dns
}
