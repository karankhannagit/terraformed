resource "aws_instance" "this" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
 
 key_name = "var.keyname"
  tags {
        Name = "var.instance_name"
  }

   user_data = <<-EOF

#!/bin/bash
sudo mkdir /tmp/keys
sudo chown ubuntu /tmp/keys
-EOF



   connection {
    user         = "ubuntu"
    private_key  = "${file("/root/.ssh/id_rsa")}"
}


  provisioner "file" {
    source      = "/root/.ssh/id_rsa"
    destination = "/tmp/keys"
      }

  user_data = <<-EOF
#!/bin/bash
sudo chown ubuntu /etc/hosts
sudo echo "172.16.1.110  chefserver.example.com chefserver" >> /etc/h$
sudo echo "172.16.1.109  chefnode.example.com chefnode" >> /etc/hosts

sleep 100s
sudo apt-get update
cd /home/ubuntu
sudo wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/1$
sudo dpkg -i chefdk_2.5.3-1*
sudo git clone https://github.com/learn-chef/learn_chef_apache2.git
sudo sleep 600s
sudo scp  -i /tmp/keys -o StrictHostKeyChecking=no  ubuntu@172.16.1.1$
sudo mv /tmp/knife.rb .
sudo knife ssl fetch
sudo knife ssl check
sudo knife cookbook upload learn_chef_apache2
sudo knife bootstrap chefnode --ssh-user ubuntu -i /tmp/keys --sudo -$
-EOF


 }


