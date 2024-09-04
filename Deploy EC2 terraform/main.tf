# Define the EC2 instance
resource "aws_instance" "example" {
  count =  2
  ami           = "ami-066784287e358dad1"  # Replace with your preferred AMI ID
  instance_type = "t2.micro"
  key_name      = "server" # Replace with your preferred key pair name
  security_groups = [aws_security_group.network-security-group.name]
  tags = {
    Name = "slope-server-${count.index}"
  }
 user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker
              sudo yum install -y docker
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              sudo docker run -d -p 80:80 --name nginx-test nginx
              EOF
 
}

# Creating a security group to restrict/allow inbound connectivity
resource "aws_security_group" "network-security-group" {
  name        = var.network-security-group-name
  description = "Allow TLS inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
   ingress {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }
  # Not recommended to add "0.0.0.0/0" instead we need to be more specific with the IP ranges to allow connectivity from.
  tags = {
    Name = "nsg-inbound"
  }
}