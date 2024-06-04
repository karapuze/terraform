resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = yandex_compute_instance.web,
      databases  = yandex_compute_instance.db,
      storage    = [yandex_compute_instance.storage]
    }
  )

  filename = "${abspath(path.module)}/hosts.cfg"
}

resource "local_file" "ansible_cfg" {
  content = <<-EOT
  [defaults]
  host_key_checking = False
  EOT

  filename = "${abspath(path.module)}/ansible.cfg"
}
