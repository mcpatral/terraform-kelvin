resource "aws_security_group" "mcpatral-bean-elb-sg" {
  name        = "mcpatral-bean-elb"
  description = "security group for bean-elb"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mcpatral-bastion-sg" {
  name        = "mcpatral-bastion-sg"
  description = "security group for bastion ec2 instance"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.MYIP]
  }
}
resource "aws_security_group" "mcpatral-prod-sg" {
  name        = "mcpatral-prod-sg"
  description = "security group for beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.mcpatral-bastion-sg.id]
  }
}

resource "aws_security_group" "mcpatral-backend-sg" {
  name        = "mcpatral-backend-sg"
  description = "security group for RDS, active mq elastic cache"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    protocol        = "tcp"
    to_port         = 0
    security_groups = [aws_security_group.mcpatral-prod-sg.id]
  }
  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.mcpatral-bastion-sg.id]
  }
}

resource "aws_security_group_rule" "sec-group-allow-itself" {
  security_group_id        = aws_security_group.mcpatral-backend-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 0
  to_port                  = 65535
  source_security_group_id = aws_security_group.mcpatral-backend-sg.id
}
