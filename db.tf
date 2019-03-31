resource "aws_rds_cluster_instance" "master" {
  count = 1
  identifier = "master"
  engine = "aurora-mysql"
  cluster_identifier = "${aws_rds_cluster.master.id}"
  instance_class = "db.t2.small"
}

resource "aws_rds_cluster" "master" {
  cluster_identifier = "master"
  engine = "aurora-mysql"
  availability_zones = ["us-east-2a"]
  database_name = "kpdb"
  master_username = "${var.master-user}"
  master_password = "${var.master-pass}"
  db_subnet_group_name = "${aws_db_subnet_group.main.name}"
  skip_final_snapshot = true
  backup_retention_period = 7
  preferred_backup_window = "09:00-10:00"
  preferred_maintenance_window = "mon:11:00-mon:12:00"
  port = "5432"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  storage_encrypted = true
  tags {
    Name = "master"
  }
}
