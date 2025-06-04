 resource "kubernetes_deployment" "cluster_autoscaler" {
  metadata {
    name      = "cluster-autoscaler"
    namespace = "kube-system"
    labels = {
      app = "cluster-autoscaler"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cluster-autoscaler"
      }
    }

    template {
      metadata {
        labels = {
          app = "cluster-autoscaler"
        }
      }

      spec {
        container {
          name  = "cluster-autoscaler"
          image = "k8s.gcr.io/autoscaling/cluster-autoscaler:v1.29.0"
          command = [
            "./cluster-autoscaler",
            "--cluster-name=${module.eks.cluster_name}",
            "--balance-similar-node-groups",
            "--skip-nodes-with-local-storage=false",
            "--expander=least-waste"
          ]

          env {
            name  = "AWS_REGION"
            value = var.aws_region
          }
        }

        service_account_name = "cluster-autoscaler"
      }
    }
  }
}
