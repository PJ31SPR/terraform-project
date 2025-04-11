# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "task_listing_app" {
  name        = "patsy-task-listing-app"
  description = "Task listing application"
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "task_listing_app_environment" {
  name                = "patsy-task-listing-app-env"
  application         = aws_elastic_beanstalk_application.task_listing_app.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.1 running Docker"
  
  # EC2 Instance Profile
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.elastic_beanstalk_ec2_instance_profile.name
  }
  
  # EC2 Key Pair for SSH Access
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "patsy-new-key-ec2-task"  # Replace with your actual key pair name
  }
  
  # Instance type
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"  
    value     = "t2.micro"
  }
  
  # Environment type (single instance to save costs during development)
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }
  
  # Deployment policy
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "AllAtOnce"
  }
  
  # Health check URL
  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/"
  }

  # Load Balancer Type
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = aws_db_instance.rds_app.address
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_DATABASE"
    value     = aws_db_instance.rds_app.db_name
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = aws_db_instance.rds_app.username
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = aws_db_instance.rds_app.password
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PORT"
    value     = aws_db_instance.rds_app.port
  }

}

# Output the Elastic Beanstalk environment URL
output "elastic_beanstalk_environment_url" {
  value = aws_elastic_beanstalk_environment.task_listing_app_environment.endpoint_url
}