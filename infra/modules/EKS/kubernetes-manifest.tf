# Kubernetes Deployment Manifest
resource "kubernetes_deployment_v1" "python_casetext" {
  metadata {
    name = "python-casetext"
    labels = {
      app = "casetext"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "casetext"
      }
    }

    template {
      metadata {
        labels = {
          app = "casetext"
        }
      }

      spec {
        container {
          image = "paarthsharma/casetext:latest"
          name  = "python-casetext"
          port {
            container_port = 8000
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "load_balancer" {
  metadata {
    name = "application-load-balancer"
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.python_casetext.spec.0.selector.0.match_labels.app
    }
    port {
      port        = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}