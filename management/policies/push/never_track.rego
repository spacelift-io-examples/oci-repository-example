package spacelift

track   { false }
propose { not is_null(input.pull_request) }
ignore  { not track; not propose }
