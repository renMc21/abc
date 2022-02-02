module "firewall-rules" {
  source       = "../../modules/terraform-google-network/modules/firewall-rules"
  project_id   = var.project_id
  network_name = var.network_name
  
  depends_on = [
    module.test-vpc-module
  ]
  rules = [{
    name                    = "prod-deptx-reg-fw-ingress-01"
    description             = null
    direction               = "INGRESS"
    priority                = 1000
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = ["prod-deptx-reg-tag-mgmt"]
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    deny = []
    enable_logging = false          # cant get it to disable logging bc log_config block enables it, cant remove log_config block bc its required from blueprint
    log_config = {
      metadata = "EXCLUDE_ALL_METADATA"
    }
    
  },
  {
    name                    = "prod-deptx-reg-fw-ingress-99"
    description             = null
    direction               = "INGRESS"
    priority                = 65000
    ranges                  = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = []
    deny = [{
        protocol = "all"
        ports    = null
    }]
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]

}
