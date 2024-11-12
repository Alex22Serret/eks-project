resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "kubernetes_manifest" "argocd_install" {
  provider = kubernetes
  manifest = yamldecode(file("https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"))
  depends_on = [kubernetes_namespace.argocd]
}
