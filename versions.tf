terraform {
  backend "remote" {
    organization = "bitraorg"  # HCP org
    workspaces {
      name = "topalpha"        # Exact workspace name
    }
  }
}
