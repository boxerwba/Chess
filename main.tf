provider "aws" {
  access_key = "AKIAWFVWA7VD54UFWD5W"
  secret_key = "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"
  region = "eu-central-1"
}
resource "aws_instance" "my_back" {
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
    Name = "back"
    Owner = "Dima Kyryakov"
    Project = "Demo4"
  }
  user_data = file("1.sh")
}
