resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1 : 0
  peer_vpc_id   = data.aws_vpc.default.id  # accepter
  vpc_id        = aws_vpc.main.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  auto_accept = true 

  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-default"
    }
  )

  }

resource "aws_route" "public_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    =data.aws_vpc.default.cidr_block
  vpc_peering_connection_id =aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.main.id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id =aws_vpc_peering_connection.default[count.index].id
}

# count = 0 is used to disable the creation of a resource
# count = 1 means create exactly one instance of a resource or module
# In a list, an element can be accessed only using its index, whether the list has one element or many. [count.index]