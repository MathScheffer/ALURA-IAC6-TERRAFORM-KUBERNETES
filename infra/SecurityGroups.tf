resource "aws_security_group" "ssh_cluster" {
  name        = "ssh_cluster"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ssh_cluster_in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp" 
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.ssh_cluster.id
}

resource "aws_security_group_rule" "ssh_cluster_eg" {
  type              = "egress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "-1" #aceita todos protocolos
  cidr_blocks       = ["0.0.0.0/0"] #0.0.0.0 - 255.255.255.255
  security_group_id = aws_security_group.ssh_cluster.id
}
