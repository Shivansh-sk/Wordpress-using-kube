provider "kubernetes" {
  config_context_cluster = "minikube"
}
resource "kubernetes_service" "service" {
  metadata {
    name = "wordpress"
  }
  spec {
    selector = {
      app = "wordpress"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
      node_port = 30001
    }
type = "NodePort"
  }
}
resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "wordpress"
    labels = {
      app = "wordpress"
    }
  }
spec {
    replicas = 3
selector {
      match_labels = {
        app = "wordpress"
      }
    }
template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }
spec {
        container {
          image = "wordpress"
          name  = "wordpress"
        }
      }
    }
  }

provider "aws" {
  region  = "ap-south-1"
  profile = "shivanshk"
}

resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "shivansh"
  password             = "kube_deployment"
  port                 = 3306
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  skip_final_snapshot = true

  tags  = {
    name = "MySQL"
  }
}







