
data "aws_ami" "ubuntu" {
most_recent = true
filter {
name = "name"
values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
}

}
resource "aws_launch_template" "webserver" {
name_prefix = "${terraform.workspace}"
image_id = data.aws_ami.ubuntu.id
instance_type = "t2.micro"
key_name = var.ssh_keypair
vpc_security_group_ids = [var.sg.websvr]
}
resource "aws_autoscaling_group" "webserver" {
name = "${terraform.workspace}-asg"
min_size = 1
max_size = 3
vpc_zone_identifier = var.vpc.private_subnets
target_group_arns = module.alb.target_group_arns
launch_template {
id = aws_launch_template.webserver.id
version = aws_launch_template.webserver.latest_version
}
module "alb" {
source = "terraform-aws-modules/alb/aws"
version = "~> 5.0"
name = "${terraform.workspace}"
load_balancer_type = "application"
vpc_id = var.vpc.vpc_id
subnets = var.vpc.public_subnets
security_groups = [var.sg.lb]
http_tcp_listeners = [
{
port = 80,
protocol = "HTTP"
target_group_index = 0
}
]
target_groups = [
{ name_prefix = "websvr",
backend_protocol = "HTTP",
backend_port = 8080
target_type = "instance"
}
]
}