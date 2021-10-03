module "aci_error_disabled_recovery" {
  source  = "netascode/error-disabled-recovery/aci"
  version = ">= 0.0.1"

  interval   = 600
  mcp_loop   = true
  ep_move    = true
  bpdu_guard = true
}
