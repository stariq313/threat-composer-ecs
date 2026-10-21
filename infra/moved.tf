moved {
  from = aws_vpc.main
  to   = module.network.aws_vpc.main
}

moved {
  from = aws_subnet.public_a
  to   = module.network.aws_subnet.public_a
}

moved {
  from = aws_subnet.public_b
  to   = module.network.aws_subnet.public_b
}

moved {
  from = aws_internet_gateway.igw
  to   = module.network.aws_internet_gateway.igw
}

moved {
  from = aws_route_table.public_rt
  to   = module.network.aws_route_table.public_rt
}

moved {
  from = aws_route_table_association.public_a_association
  to   = module.network.aws_route_table_association.public_a_association
}

moved {
  from = aws_route_table_association.public_b_association
  to   = module.network.aws_route_table_association.public_b_association
}

moved {
  from = aws_subnet.private_a
  to   = module.network.aws_subnet.private_a
}

moved {
  from = aws_subnet.private_b
  to   = module.network.aws_subnet.private_b
}

moved {
  from = aws_route_table.private_rt
  to   = module.network.aws_route_table.private_rt
}

moved {
  from = aws_route_table_association.private_a_association
  to   = module.network.aws_route_table_association.private_a_association
}

moved {
  from = aws_route_table_association.private_b_association
  to   = module.network.aws_route_table_association.private_b_association
}

moved {
  from = aws_security_group.alb_sg
  to   = module.security.aws_security_group.alb_sg
}

moved {
  from = aws_security_group.ecs_sg
  to   = module.security.aws_security_group.ecs_sg
}

moved {
  from = aws_vpc_security_group_ingress_rule.alb_http
  to   = module.security.aws_vpc_security_group_ingress_rule.alb_http
}

moved {
  from = aws_vpc_security_group_ingress_rule.alb_https
  to   = module.security.aws_vpc_security_group_ingress_rule.alb_https
}

moved {
  from = aws_vpc_security_group_egress_rule.alb_all_outbound
  to   = module.security.aws_vpc_security_group_egress_rule.alb_all_outbound
}

moved {
  from = aws_vpc_security_group_ingress_rule.ecs_from_alb
  to   = module.security.aws_vpc_security_group_ingress_rule.ecs_from_alb
}

moved {
  from = aws_vpc_security_group_egress_rule.ecs_all_outbound
  to   = module.security.aws_vpc_security_group_egress_rule.ecs_all_outbound
}

moved {
  from = aws_ecs_cluster.main
  to   = module.ecs.aws_ecs_cluster.main
}

moved {
  from = aws_ecs_task_definition.app
  to   = module.ecs.aws_ecs_task_definition.app
}

moved {
  from = aws_iam_role.ecs_task_execution_role
  to   = module.ecs.aws_iam_role.ecs_task_execution_role
}

moved {
  from = aws_iam_role_policy_attachment.ecs_task_execution_policy
  to   = module.ecs.aws_iam_role_policy_attachment.ecs_task_execution_policy
}

moved {
  from = aws_cloudwatch_log_group.app
  to   = module.ecs.aws_cloudwatch_log_group.app
}

moved {
  from = data.aws_iam_policy_document.ecs_task_execution_assume_role
  to   = module.ecs.data.aws_iam_policy_document.ecs_task_execution_assume_role
}