 provider "google" {
     credentials = file("gcp-account.json")
     project     = "festive-canto-350505"
     region      = "asia-south1"
     zone        = "asia-south1-c"
}