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