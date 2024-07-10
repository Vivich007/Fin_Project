provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "AnsibleMaster" {
  ami           = "ami-08be1e3e6c338b037"
  instance_type = "t2.micro"
  key_name      = "plank"
  vpc_security_group_ids = [
    "sg-0a4641cefb37dae10", # permit SSH
    "sg-0909caa8a7d538f7c"  # permit 8080
  ]
  subnet_id = "subnet-04d3f8835719f6544"
  private_ip = "172.31.25.25"
  tags = {
    Name = "AnsibleMaster"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf -y install git",
      "sudo dnf install curl -y",
      "sudo dnf -y install awscli"
      "sudo dnf -y install docker",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ec2-user",
      "sudo dnf -y install epel-release",
      "sudo dnf -y install ansible",
      "ansible-galaxy collection install kubernetes.core"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/plank.pem")
      host        = self.private_ip
    }
  }
}

