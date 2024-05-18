resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.default_cidr[0]]
}

resource "yandex_vpc_subnet" "develop-b" {
  name           = var.vpc_name_b
  zone           = var.b_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.default_cidr[1]]
}


data "yandex_compute_image" "ubuntu" {
  family = var.family
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_names.web
  platform_id = "standard-v1"
  zone        = var.vms_resources["web"]["zone"]
  resources {
    cores         = var.vms_resources["web"]["cores"]
    memory        = var.vms_resources["web"]["memory"]
    core_fraction = var.vms_resources["web"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = var.vms_metadata
}

resource "yandex_compute_instance" "db" {
  name        = local.vm_names.db
  platform_id = "standard-v1"
  zone        = var.vms_resources["db"]["zone"]
  resources {
    cores         = var.vms_resources["db"]["cores"]
    memory        = var.vms_resources["db"]["memory"]
    core_fraction = var.vms_resources["db"]["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-b.id
    nat       = true
  }

  metadata = var.vms_metadata
}
