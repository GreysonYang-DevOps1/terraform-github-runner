terraform {
  
  cloud {
    organization = "TFAL"

    workspaces {
      name = "TFA-Github_Runner"
    }
  }

}