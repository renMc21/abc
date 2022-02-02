module "instance_template" {
  source               = "../../modules/terraform-google-vm/modules/instance_template"
  region               = var.region
  project_id           = var.project_id
  network              = var.network
  subnetwork           = var.subnetwork
  subnetwork_project   = var.project_id
  can_ip_forward       = var.can_ip_forward
  #machine_type         = var.machine_type
  #source_image         = var.source_image
  source_image_project = var.source_image_project
  source_image_family = var.source_image_family
  disk_type            = var.disk_type
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
  service_account = {
    email  = var.sa_email
    scopes = var.scopes
  }
}

module "compute_instance" {
  source            = "../../modules/terraform-google-vm/modules/compute_instance"
  region            = var.region
  zone              = var.zone
  subnetwork        = var.subnetwork
  subnetwork_project = var.project_id
  num_instances     = var.num_instances
  hostname          = var.hostname
  instance_template = module.instance_template.self_link
  #deletion_protection = false

  #access_config = [{
  #nat_ip       = var.nat_ip
  #network_tier = var.network_tier
  #}, ]

}
