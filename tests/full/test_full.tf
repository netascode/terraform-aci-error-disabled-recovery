terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  interval   = 600
  mcp_loop   = true
  ep_move    = true
  bpdu_guard = true
}

data "aci_rest" "edrErrDisRecoverPol" {
  dn = "uni/infra/edrErrDisRecoverPol-default"

  depends_on = [module.main]
}

resource "test_assertions" "edrErrDisRecoverPol" {
  component = "edrErrDisRecoverPol"

  equal "errDisRecovIntvl" {
    description = "errDisRecovIntvl"
    got         = data.aci_rest.edrErrDisRecoverPol.content.errDisRecovIntvl
    want        = "600"
  }
}

data "aci_rest" "edrEventP-event-mcp-loop" {
  dn = "${data.aci_rest.edrErrDisRecoverPol.id}/edrEventP-event-mcp-loop"

  depends_on = [module.main]
}

resource "test_assertions" "edrEventP-event-mcp-loop" {
  component = "edrEventP-event-mcp-loop"

  equal "recover" {
    description = "recover"
    got         = data.aci_rest.edrEventP-event-mcp-loop.content.recover
    want        = "yes"
  }
}

data "aci_rest" "edrEventP-event-ep-move" {
  dn = "${data.aci_rest.edrErrDisRecoverPol.id}/edrEventP-event-ep-move"

  depends_on = [module.main]
}

resource "test_assertions" "edrEventP-event-ep-move" {
  component = "edrEventP-event-ep-move"

  equal "recover" {
    description = "recover"
    got         = data.aci_rest.edrEventP-event-ep-move.content.recover
    want        = "yes"
  }
}

data "aci_rest" "edrEventP-event-bpduguard" {
  dn = "${data.aci_rest.edrErrDisRecoverPol.id}/edrEventP-event-bpduguard"

  depends_on = [module.main]
}

resource "test_assertions" "edrEventP-event-bpduguard" {
  component = "edrEventP-event-bpduguard"

  equal "recover" {
    description = "recover"
    got         = data.aci_rest.edrEventP-event-bpduguard.content.recover
    want        = "yes"
  }
}
