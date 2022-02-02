region               = "us-east4"
zone                 = "us-east4-c"
project_id           = "tf-poc-339319"
subnetwork           = "prod-deptx-reg-net-01"

sa_email             = "testsa@tf-poc-339319.iam.gserviceaccount.com"
scopes               = ["cloud-platform"]
num_instances        = "1"
hostname             = "prod-deptx-reg-bastion-01"
machine_type         = "e2.medium"
#source_image         = "ubuntu-os-cloud/ubuntu-2004-lts"
source_image_project = "ubuntu-os-cloud"
source_image_family  = "ubuntu-2004-lts"
disk_size_gb         = "10"
disk_type            = "pd-standard"
tags                 = ["prod-deptx-reg-tag-mgmt"]
network              = "prod-deptx-reg-vpc-01"

#nat_ip = ""
#network_tier = ""
