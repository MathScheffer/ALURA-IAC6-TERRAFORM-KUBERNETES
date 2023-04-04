module "prod" {
  source = "../../infra"

  nome_repositorio = "prod"
  cluster_name = "prod"
}

