
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

resource "aws_s3_bucket" "ci_cd_bucket" {
  bucket = "${var.bucketname}"
  acl    = "private"

  tags = {
    Name        = "${var.bucketname}"
    Environment = "Dev"
  }

  region = "${var.region}"
}
output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

output "instancestate" {
  value = "${aws_instance.example.instance_state}"
}