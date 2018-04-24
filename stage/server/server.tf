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

sudo wget https://packages.chef.io/files/stable/chef-server/12.17.33/$
sudo dpkg -i chef-server*
sudo chef-server-ctl reconfigure
sudo chef-server-ctl user-create admin alpha beta steved@chef.io 'abc$
sudo chown ubuntu /admin.pem
sudo chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --ass$
sudo chef-server-ctl install chef-manage
sudo chef-manage-ctl reconfigure --accept-license
-EOF

 }


