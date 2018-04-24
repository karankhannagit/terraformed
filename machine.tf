provider "aws"{
  access_key="${var.aws_access_key}"
  secret_key="${var.aws_secret_key}"
  region    ="${var.region}"
}

resource "aws_key_pair" "deployer" {
  key_name = "web_key_2"
  public_key = "${file("/root/.ssh/id_rsa.pub")}"
}

module "vpc" 
{
source ="/terradata14/stage/vpcconf"
}

module "security_group"
{
source ="/terradata14/stage/sg"
vpc_id = "module.vpc.my_vpc_id"
}

module "public_subnet"
{
source ="/terradata14/stage/subnet/publicSub/"
vpc_id = "module.vpc.my_vpc_id" 

}

module "private_subnet"
{
source ="/terradata14/stage/subnet/privateSub/"


}


