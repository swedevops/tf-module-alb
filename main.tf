resource "aws_security_group" "sg" {
  name        = "${var.name}-alb-${var.env}-sg"
  description = "${var.name}-alb-${var.env}-sg"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.allow_alb_cidr

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, { name = "${var.name}-alb-${var.env}-sg" })

}

resource "aws_lb" "main" {
  name               = "${var.name}-alb-${var.env}"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = var.subnets
  tags               = merge(var.tags, { name = "${var.name}-alb-${var.env}" })
}












