resource "spacelift_policy" "reject_all_except_prs" {
  name = "reject-all-except-prs"
  body = file("./policies/approval/reject_all_except_prs.rego")
  type = "APPROVAL"

  labels = ["autoattach:proposal-stack"]

  space_id = "root"
}

resource "spacelift_policy" "never_track" {
  name = "never-track"
  body = file("./policies/push/never_track.rego")
  type = "GIT_PUSH"

  labels = ["autoattach:proposal-stack"]

  space_id = "root"
}

resource "spacelift_policy" "never_track_or_propose" {
  name = "never-track-or-propose"
  body = file("./policies/push/never_track_or_propose.rego")
  type = "GIT_PUSH"

  labels = ["autoattach:oci-automation"]

  space_id = "root"
}