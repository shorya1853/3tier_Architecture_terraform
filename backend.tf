terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-vieer"
    key = "terraform.state"
    region = "us-east-1"
  }
}
