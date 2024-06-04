resource "yandex_compute_disk" "data_disk" {
  count = 3
  name  = "data-disk-${count.index + 1}"
  size  = 1
  type  = "network-hdd"
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name = "storage"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_key}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data_disk
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
