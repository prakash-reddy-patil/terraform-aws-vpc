resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  # Tags must be created as per the project standard: project_name-environment-resource_name.
  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
      Name = local.common_name_suffix
    }
  )
}

# IGW
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
      Name = local.common_name_suffix
    }
  )
}

# subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true # Any EC2 instance launched in that subnet will automatically get a public IP address

  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
      Name = "${local.common_name_suffix}-public-${local.az_names[count.index]}" # roboshop-dev-public-us-east-1a
    }
  )
}


resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
 
  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
      Name = "${local.common_name_suffix}-private-${local.az_names[count.index]}"  # roboshop-dev-private-us-east-1a
    }
  )
}


resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  
  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
      Name = "${local.common_name_suffix}-database-${local.az_names[count.index]}" # roboshop-dev-database-us-east-1a
    }
  )
}
