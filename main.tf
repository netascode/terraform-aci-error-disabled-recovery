resource "aci_rest" "edrErrDisRecoverPol" {
  dn         = "uni/infra/edrErrDisRecoverPol-default"
  class_name = "edrErrDisRecoverPol"
  content = {
    name             = "default"
    errDisRecovIntvl = var.interval
  }
}

resource "aci_rest" "edrEventP-event-mcp-loop" {
  dn         = "${aci_rest.edrErrDisRecoverPol.id}/edrEventP-event-mcp-loop"
  class_name = "edrEventP"
  content = {
    event   = "event-mcp-loop"
    recover = var.mcp_loop == true ? "yes" : "no"
  }
}

resource "aci_rest" "edrEventP-event-ep-move" {
  dn         = "${aci_rest.edrErrDisRecoverPol.id}/edrEventP-event-ep-move"
  class_name = "edrEventP"
  content = {
    event   = "event-ep-move"
    recover = var.ep_move == true ? "yes" : "no"
  }
}

resource "aci_rest" "edrEventP-event-bpduguard" {
  dn         = "${aci_rest.edrErrDisRecoverPol.id}/edrEventP-event-bpduguard"
  class_name = "edrEventP"
  content = {
    event   = "event-bpduguard"
    recover = var.bpdu_guard == true ? "yes" : "no"
  }
}
