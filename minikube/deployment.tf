resource "kubernetes_deployment" "nginx" {
    metadata {
        name = "nginx"
        namespace = "rahasak"
    }
    spec {
        replicas = 2
        selector {
            match_labels = {
                app = "nginx"
            }
        }
        template {
            metadata {
                labels = {
                    app = "nginx"
                }
            }
            spec {
                container {
                    image = "nginx"
                    name = "nginx"
                    port {
                        container_port = 80
                    }
                }
            }
        }
    }
}

resource "kubernetes_service" "nginx" {
    metadata {
        name = "nginx"
        namespace = "rahasak"
    }
    spec {
        selector = {
            app = kubernetes_deployment.nginx.spec.0.template.0.metadata.0.labels.app
        }
        port {
            port = 80
        }
    }
}
