# יצירת ה-VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "devops-project-vpc"
    Environment = "Dev"
  }
}

# יצירת Subnet ציבורי
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "devops-project-public-subnet"
  }
}

# יצירת Internet Gateway לחיבור הרשת לאינטרנט החיצון
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "devops-project-igw"
  }
}

# טבלת ניתוב עבור תעבורה לאינטרנט
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "devops-project-public-rt"
  }
}

# שיוך טבלת הניתוב ל-Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}