provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "java" {
  metadata {
    name      = "java"
    namespace = "default"

    labels = {
      app = "java"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "java"
      }
    }

    template {
      metadata {
        labels = {
          app = "java"
        }
      }

      spec {
        container {
          name  = "java"
          image = "demo:1.1.0"

          port {
            name           = "java"
            container_port = 8080
          }

          liveness_probe {
            http_get {
              path = "/status"
              port = "8080"
            }

            period_seconds    = 10
            failure_threshold = 1
          }

          startup_probe {
            http_get {
              path = "/status"
              port = "8080"
            }

            period_seconds    = 10
            failure_threshold = 30
          }
        }
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_unavailable = "25%"
        max_surge       = "25%"
      }
    }
  }
}

resource "kubernetes_service" "java" {
  metadata {
    name      = "java"
    namespace = "default"

    labels = {
      app = "java"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 8080
      target_port = "8080"
    }

    selector = {
      app = "java"
    }

    type                    = "LoadBalancer"
    session_affinity        = "None"
    external_traffic_policy = "Cluster"
    ip_families             = ["IPv4"]
  }
}

