###variables_for_vm web

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name VM"
}

variable "cores" {
  type        = number
  default     = 2
  description = "vCPU cores"
}

variable "memory" {
  type        = number
  default     = 1
  description = "RAM size"
}

variable "core_fraction" {
  type        = number
  default     = 5
  description = "% fraction vCPU"
}

###variables_for_vm_db

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name VM"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "vCPU cores"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "RAM size"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "% fraction vCPU"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "available zone"
}