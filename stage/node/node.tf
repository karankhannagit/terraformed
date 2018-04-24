resource "aws_instance" "this" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "var.instance_type"

     network_interface {
     network_interface_id = "${var.net_int_id}"
     device_index = 0
  }


  key_name = "var.keyname"
  tags {
        Name = "var.instance_name"
  }

 user_data = <<-EOF
#!/bin/bash
cd ~
sudo chown ubuntu /etc/hosts
sudo echo "172.16.1.110  chefserver.example.com chefserver" >> /etc/h$
sudo echo "172.16.1.109  chefnode.example.com chefnode" >> /etc/hosts
-EOF

  }

