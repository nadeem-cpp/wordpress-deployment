terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {

}

module "vpc" {
  source = "./modules/vpc"
  availability_zones = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}

module "security_groups" {
  source = "./modules/sg"
  # vpc_id = "vpc-0d4569dd17aef6fea"
  vpc_id = module.vpc.vpc_id
}

module "database"{
  source = "./modules/rds"
  engine = var.database_engine
  master_password = var.db_password
  username = var.db_password
  instance_class = var.instance_class
  subnet_ids = module.vpc.subnet_ids["private"]
}

module "load_balancer" {
  source = "./modules/lb"
  security_groups = [module.security_groups.lb_sg_id]
  vpc_id = module.vpc.vpc_id
  # subnets =  [ "subnet-003a1f05fb5122dd1", "subnet-0ed74f5884e560bc2" ]
  subnet_ids = module.vpc.subnet_ids["public"]
  
}


module "autoscaling_group" {
  source = "./modules/asg"
  sg_ids = [ module.security_groups.instance_sg_id ]
  target_group_arns = [ module.load_balancer.lb_target_group.arn ]
  availability_zones = module.vpc.subnet_ids["public"]
}



##################### cloudfront ########################
##################### s3 ########################
##################### parameter manager ########################
