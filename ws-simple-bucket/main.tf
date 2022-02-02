module "bucket" {
  source = "../../modules/terraform-google-cloud-storage/modules/simple_bucket"

  name               = var.name
  project_id         = var.project_id
  location           = var.location
  storage_class      = var.storage_class
  bucket_policy_only = var.bucket_policy_only
  
  #CFT given lifecycle rules
  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age        = 365
      with_state = "ANY"
    }
  }]

  /*
  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "user:example-user@example.com"
  }]
  */
}
