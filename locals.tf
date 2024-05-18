locals {
  vm_names = {
    web = "${var.vms_resources["web"]["name"]}-${var.vms_resources["web"]["zone"]}"
    db  = "${var.vms_resources["db"]["name"]}-${var.vms_resources["db"]["zone"]}"
  }
}
