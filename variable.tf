variable "vpc_cidr" {
    type = string
    description = "please provide vpc CIDR"
}

variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}

variable "vpc_tags" {
    type = map 
    default = {}  # optiona
}

variable "igw_tags" {
    type = map
    default ={}
}

variable "public_subnet_cidrs" {
    type = list 
}

variable "public_subnet_tags" {
    type =map
    default ={}  # optional
}

variable "private_subnet_cidrs" {
    type =list
}

variable "private_subnet_tags" {
    type =map
    default ={}  # optional
}

variable "database_subnet_cidrs" {
    type = list
}

variable "database_subnet_tags" {
    type =map
    default ={}  # optional
}