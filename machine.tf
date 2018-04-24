provider "aws"{
  access_key="${var.aws_access_key}"
  secret_key="${var.aws_secret_key}"
  region    ="us-east-2"
}



resource "aws_vpc" "cloudroom" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames  = "true"
  tags {
    Name = "cloudroom"
  }
}


resource "aws_security_group" "web_server_cr" {
  name = "web_server_cr"
 

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.cloudroom.id}"
}


resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.cloudroom.id}"
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"
  tags = {
  Name =  "Subnet Pub"
  }
}



resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.cloudroom.id}"
  cidr_block              = "172.16.2.0/24"
  availability_zone = "us-east-2a"
  tags = {
  Name =  "Subnet Priv"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.cloudroom.id}"
  tags {
        Name = "InternetGateway"
    }
}



resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.cloudroom.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_eip" "tuto_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.tuto_eip.id}"
    subnet_id = "${aws_subnet.public.id}"
    depends_on = ["aws_internet_gateway.gw"]
}


resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.cloudroom.id}"

    tags {
        Name = "Private route table"
    }
}


resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}
  



resource "aws_route_table_association" "pubasstab" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_vpc.cloudroom.main_route_table_id}"
}

resource "aws_route_table_association" "privasstab" {
    subnet_id = "${aws_subnet.private.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}


resource "aws_network_interface" "node" {
  subnet_id = "${aws_subnet.public.id}"
  private_ips = ["172.16.1.109"]
 

  tags {
    Name = "primary_network_interface"
  }
}


resource "aws_network_interface" "server" {
  subnet_id = "${aws_subnet.public.id}"
  private_ips = ["172.16.1.110"]
 

  tags {
    Name = "primary_network_interface"
  }
}



resource "aws_key_pair" "deployer" {
  key_name = "web_key_2"
  public_key = "${file("/root/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "chefnode" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  
     network_interface {
     network_interface_id = "${aws_network_interface.node.id}"
     device_index = 0
  } 


  key_name = "web_key_2"
  tags {
        Name = "chefnode"
  }

 user_data = <<-EOF
#!/bin/bash
cd ~
sudo chown ubuntu /etc/hosts
sudo echo "172.16.1.110  chefserver.example.com chefserver" >> /etc/hosts
sudo echo "172.16.1.109  chefnode.example.com chefnode" >> /etc/hosts
-EOF
  



  }


resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.web_server_cr.id}"
  network_interface_id = "${aws_network_interface.node.id}"

}


resource "aws_instance" "chefserver" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.large"
     network_interface {
     network_interface_id = "${aws_network_interface.server.id}"
     device_index = 0
  }

  

  
  key_name = "web_key_2"
  tags {
        Name = "chefserver"
  }

 user_data = <<-EOF
#!/bin/bash
cd ~

sudo chown ubuntu /etc/hosts
sudo echo "172.16.1.110  chefserver.example.com chefserver" >> /etc/hosts
sudo echo "172.16.1.109  chefnode.example.com chefnode" >> /etc/hosts

sudo wget https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb
sudo dpkg -i chef-server*
sudo chef-server-ctl reconfigure
sudo chef-server-ctl user-create admin alpha beta steved@chef.io 'abc1234567' --filename /admin.pem
sudo chown ubuntu /admin.pem
sudo chef-server-ctl org-create 4thcoffee 'Fourth Coffee, Inc.' --association_user admin --filename validator.pem
sudo chef-server-ctl install chef-manage
sudo chef-manage-ctl reconfigure --accept-license
-EOF

 }

resource "aws_network_interface_sg_attachment" "sg_attachment2" {
  security_group_id    = "${aws_security_group.web_server_cr.id}"
  network_interface_id = "${aws_network_interface.server.id}"

}



resource "aws_instance" "workstation" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = true 
  subnet_id = "${aws_subnet.public.id}"  
  vpc_security_group_ids = ["${aws_security_group.web_server_cr.id}"]

  key_name = "web_key_2"
  tags {
        Name = "workstation"
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

   connection {
    user         = "ubuntu"
    private_key  = "${file("/root/.ssh/id_rsa")}"
}


  provisioner "file" {
    source      = "/terradata10/knife.rb"
    destination = "/tmp/knife.rb"
      }



  user_data = <<-EOF
#!/bin/bash
sudo chown ubuntu /etc/hosts
sudo echo "172.16.1.110  chefserver.example.com chefserver" >> /etc/hosts
sudo echo "172.16.1.109  chefnode.example.com chefnode" >> /etc/hosts

sleep 100s
sudo apt-get update
cd /home/ubuntu
sudo wget https://packages.chef.io/files/stable/chefdk/2.5.3/ubuntu/16.04/chefdk_2.5.3-1_amd64.deb
sudo dpkg -i chefdk_2.5.3-1*
sudo git clone https://github.com/learn-chef/learn_chef_apache2.git
sudo sleep 600s
sudo scp  -i /tmp/keys -o StrictHostKeyChecking=no  ubuntu@172.16.1.110:/admin.pem .
sudo mv /tmp/knife.rb . 
sudo knife ssl fetch
sudo knife ssl check 
sudo knife cookbook upload learn_chef_apache2
sudo knife bootstrap chefnode --ssh-user ubuntu -i /tmp/keys --sudo --identity-file admin.pem --node-name chefnode --run-list 'recipe[learn_chef_apache2]'
-EOF


 }



