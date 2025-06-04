 # יצירת טבלת ניתוב פרטית
resource "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = module.vpc.natgw_ids[0]
  }

  tags = {
    Name = "private-route-table"
  }
}
