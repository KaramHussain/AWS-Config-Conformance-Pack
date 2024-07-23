terraform {
  backend "s3" {
    key    = "terraform2/tfstate.tfstate"
    bucket = "karamterraformstatefile"
    region = "us-east-1"
  }
}