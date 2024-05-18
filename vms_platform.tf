variable "b_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "available zone"
}

variable "vms_resources" {
  type = map(object({
    name          = string
    cores         = number
    memory        = number
    core_fraction = number
    zone          = string
  }))
  default = {
    web = {
      name          = "netology-develop-platform-web"
      cores         = 2
      memory        = 1
      core_fraction = 5
      zone          = "ru-central1-a"
    }
    db = {
      name          = "netology-develop-platform-db"
      cores         = 2
      memory        = 2
      core_fraction = 20
      zone          = "ru-central1-b"
    }
  }
}

variable "vms_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh_keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINwZpHY4prQOwRvVoKdw8Hj00O2MorM4+krJXInepj9i karapuze@yandex.ru"
  }
}

###variables_for_vm web
#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "Name VM"
#}

#variable "vm_web_cores" {
#  type        = number
#  default     = 2
#  description = "vCPU cores"
#}

#variable "vm_web_memory" {
#  type        = number
#  default     = 1
#  description = "RAM size"
#}

#variable "vm_web_core_fraction" {
#  type        = number
#  default     = 5
#  description = "% fraction vCPU"
#}

###variables_for_vm_db

#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "Name VM"
#}
#variable "vm_db_cores" {
#  type        = number
#  default     = 2
#  description = "vCPU cores"
#}

#variable "vm_db_memory" {
#  type        = number
#  default     = 2
#  description = "RAM size"
#}

#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20
#  description = "% fraction vCPU"
#}
