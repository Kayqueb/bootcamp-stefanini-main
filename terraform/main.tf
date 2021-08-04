terraform {
  backend "http" {
  }
}

provider "google" {
  project = "bootcamp-group3"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-default"
  auto_create_subnetworks = "false"

}

resource "google_compute_subnetwork" "subnet-default" {
  name          = "subnet-default"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id

  depends_on = [google_compute_network.vpc_network]

}

resource "google_container_cluster" "default-cluster" {
  name     = "default-cluster"
  location = "us-central1"
  initial_node_count = "1"

  depends_on = [google_compute_subnetwork.subnet-default]
}

resource "google_storage_bucket" "default-bucket" {
  name          = "kayqyenepo"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

}