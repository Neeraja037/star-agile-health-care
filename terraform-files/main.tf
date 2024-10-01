resource "aws_instance" "test-server" {
  ami = "ami-05134c8ef96964280"
  instance_type = "t2.micro"
  key_name = "staragile"
  vpc_security_group_ids = ["sg-0fe8a7968d549f29f"]
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./staragile.pem")
    host = self.public_ip
  }

  script = "path/to/your/script.sh"
}

  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Health-care/terraform-files/ansibleplaybook.yml"
     }
  }
