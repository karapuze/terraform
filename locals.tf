locals {
  vm_names = {
    web = "${var.vm_web_name}-${var.default_zone}"
    db  = "${var.vm_db_name}-${var.vm_db_zone}"
  }
}
