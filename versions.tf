terraform {
  backend "remote" {
    organization = "bitraorg"

    workspaces {
      prefix = "topalpha-"
    }
  }
}
