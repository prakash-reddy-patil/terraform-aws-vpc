data "aws_availability_zones" "available" {
  state = "available"
}


# data source of default vpc 
data "aws_vpc" "default" {
  default = true
}

 # data source of default vpc routable 
data "aws_route_table" "main" {          
  vpc_id = data.aws_vpc.default.id
  filter {
    name = "association.main"
    values = ["true"]
  }
}