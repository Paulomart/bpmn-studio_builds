workflow "New workflow" {
  on = "issue_comment"
  resolves = ["docker://alpine/git"]
}

action "docker://alpine/git" {
  uses = "docker://alpine/git"
  args = "clone https://github.com/process-engine/bpmn-studio.git"
}
