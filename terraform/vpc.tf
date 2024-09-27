resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/24"
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 5, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 5, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

#This subnets will be used for Redis
resource "aws_subnet" "database" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 5, count.index + 4)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}