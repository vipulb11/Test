provider "aws" {
    region     = "ap-south-1"
    access_key = "AKIA52EMFTQ6JJJWHPOL"
    secret_key = "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"
  }


variable "awsprops" {
   # type = "map"
    default = {
    region = "ap-south-1"
    vpc = "vpc-0f738059560ef2ea8"
    ami = "ami-06984ea821ac0a879"
    itype = "t2.micro"
    subnet = "subnet-00366c9bca4b8c1dc"
    publicip = true
    keyname = "Linux_key"
    secgroupname = "testt-SG"
      }
}

resource "aws_security_group" "test-SG" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")



   lifecycle {
    create_before_destroy = true
  }
}


resource "aws_instance" "vipul-iac" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
    aws_security_group.test-SG.id
  ]
  root_block_device {
    delete_on_termination = true
    #iops = 150
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.test-SG ]
}

output "ec2instance" {
  value = aws_instance.vipul-iac.public_ip
}
