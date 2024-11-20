
resource "aws_security_group" "web_app" {
  name        = "web_app"
  description = "security group"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "web_app"
  }
}

resource "aws_instance" "webapp_instance" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_app.id]
  tags = {
    Name = "webapp_instance"
  }
  key_name  = "us_2_access"
  user_data = <<-EOF
  #!/bin/bash
  sudo zypper install -y docker
  sudo systemctl enable docker
  sudo systemctl start docker
  sudo docker run -d -p 80:8080 denisdovgodko/lab6flask:${var.image_tag} 
  EOF
  user_data_replace_on_change = true
}

