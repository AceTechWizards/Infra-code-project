resource "aws_instance" "Moodle Application Server" {
        ami = "ami-0173ab411957a93dd"
        instance_type = "t2.micro"
        tags = {
                Name = "Moodle Application Server"
}
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "glmoodle"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  allocated_storage = 2

  name     = "mysql"
  username = "admin"
  password = "Czt732ck#"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-93f203b1"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval = "30"
  monitoring_role_name = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = AceWizard""
    Environment = "Test"
    Name        = "MoodleDB"
  }
}
