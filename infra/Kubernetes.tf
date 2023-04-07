resource "kubernetes_deployment" "Django-API" {
  metadata {
    name = "django-api"
    labels = {
      nome = "django"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        #chama o metadata acima
        nome = "django"
      }
    }
    template {
      metadata {
        labels = {
          nome = "django"
        }
      }
      spec {
        container {
          image = "266464136562.dkr.ecr.us-east-1.amazonaws.com/prod:v1"
          name  = "django"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/clientes"
              port = 8000
            }
            #Este delay serve para, caso a nossa aplicação demore para subir, o liveness_probe demora
            #igualmente para fazer as requisições
            initial_delay_seconds = 300
            period_seconds        = 3
          }
        }
      }
    }
  }
}