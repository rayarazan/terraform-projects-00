
resource "aws_db_instance" "database" {
engine = "postgres"
engine_version = "12.0"
instance_class = "db.t2.micro"
identifier = "${var.namespace}-db-instance"
name = "mydb"
username = "postgres"
password = "pass@2022"
db_subnet_group_name = var.vpc.database_subnet_group
vpc_security_group_ids = [var.sg.db]
skip_final_snapshot = true
}