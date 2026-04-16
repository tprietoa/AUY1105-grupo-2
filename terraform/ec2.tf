# --- SECURITY GROUP ---
# Requerimiento: Permitir solo tráfico entrante SSH (Puerto 22)
resource "aws_security_group" "ssh_access" {
  name        = "AUY1105-duocapp-sg"
  description = "Permitir solo SSH entrante"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH desde internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AUY1105-duocapp-sg"
  }
}

# --- INSTANCIA EC2 ---
# Requerimiento: Ubuntu 24.04 LTS y tipo t2.micro
resource "aws_instance" "servidor_web" {
  ami           = "ami-0427090fd1714168b" # ID de Ubuntu 24.04 LTS en us-east-1
  instance_type = "t2.micro"
  
  # Asociación con la subred pública
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "AUY1105-duocapp-ec2"
  }
}
