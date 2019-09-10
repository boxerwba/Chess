provider "aws" {
  access_key = "AKIAWFVWA7VDQAPCUVD2"
  secret_key = "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"
  region = "eu-central-1"
}

resource "aws_instance" "prod" {
  ami = "ami-010fae13a16763bb4"
  instance_type = "t2.micro"
  key_name = "demo4"

  availability_zone = "eu-central-1b"
  vpc_security_group_ids = ["sg-0c790e6bb304ebb48"]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  tags = {
    Name = "prod"
    Owner = "Dima Kyryakov"
    Project = "Demo4"
  }
  user_data = file("1.sh")
}






