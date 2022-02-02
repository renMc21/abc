module "test-vpc-module" {
  source = "../../modules/terraform-google-network/modules/vpc"
  #version     = "~> 4.1.0"
  project_id   = var.project_id
  network_name = var.network_name
  mtu          = 1460
}

module "vpc" {
    depends_on = [
        module.test-vpc-module
    ]
    source  = "../../modules/terraform-google-network/modules/subnets"
    #version = "~> 2.0.0"

    project_id   = var.project_id
    network_name = var.network_name
    subnets = [
        {
            subnet_name           = "prod-deptx-reg-net-01"
            subnet_ip             = "192.168.0.0/20"
            subnet_region         = "us-east4"
            subnet_private_access = "false"
            subnet_flow_logs      = "true"
            routing_mode          = "global"
        },
    ]

    secondary_ranges = {
        prod-deptx-reg-net-01 = [
            {
                range_name    = "prod-deptx-reg-net-pods-01"
                ip_cidr_range = "192.168.16.0/20"
            },
            {
                range_name    = "prod-deptx-reg-net-services-01"
                ip_cidr_range = "192.168.32.0/20"
            },
        ]

    }
}

module "routes" {
    depends_on = [
        module.test-vpc-module
    ]
    source  = "../../modules/terraform-google-network/modules/routes"

    project_id   = var.project_id
    network_name = var.network_name

    routes = [
        {
            name                   = "prod-deptx-reg-route-01"
            description            = "route through IGW to access internet"
            destination_range      = "10.0.0.0/24"
            tags                   = "prod-deptx-reg-tag-all-nodes"
            #next_hop_vpn_tunnel    = "prod-deptx-reg-vpn-01"
            next_hop_internet      = "true"
            
        },
    ]
}
