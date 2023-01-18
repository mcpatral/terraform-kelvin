resource "aws_db_subnet_group" "mcpatral-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    name = "subnet group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "mcpatral-ecache_subgrp" {
  name       = "mcpatral-ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    "name" = "subnet group for Ecache"
  }
}

#RDS Instance
resource "aws_db_instance" "mcpatral-rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.6.34"
  instance_class         = "db.t2.micro"
  name                   = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  vpc_security_group_ids = [aws_security_group.mcpatral.mcpatral-backend-sg.id]
  parameter_group_name   = "default.mysql 5.6"
  multi_az               = "false"
  publicly_accessible    = "false"
  skip_final_snapshot    = "true"
  db_subnet_group_name   = aws_db_subnet_group.mcpatral-rds-subgrp.name
  
}
#Elastic cache
resource "aws_elasticache_cluster" "mcpatral-cache" {
  cluster_id             = "mcpatral-cache"
  engine                 = "memcached"
  node_type              = "cache.t2.micro"
  notification_topic_arn = 1
  parameter_group_name   = "default.memcached 1.5"
  port                   = 11211
  security_group_ids     = [aws_security_group.mcpatral-backend-sg.id]
  subnet_group_name      = aws_elasticache_subnet_group.mcpatral-ecache_subgrp.name

}
#Amazon MQ
resource "aws_mq_broker" "mcpatral-rmq" {
  broker_name        = "mcpatral-rmq"
  engine_type        = "ActiveMQ"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.mcpatral-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    username = var.rmquser
    password = var.rmqpass
  }
}