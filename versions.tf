terraform {
  backend "remote" {
    organization = "bitraorg"

    workspaces {
      name = "topalpha"
    }
  }
}
