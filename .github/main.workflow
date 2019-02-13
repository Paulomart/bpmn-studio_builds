workflow "New workflow" {
  on = "issue_comment"
  resolves = ["docker://alpine/git"]
}

action "docker://alpine/git" {
  uses = "docker://alpine/git"
  args = "git clone https://github.com/process-engine/bpmn-studio.git"
}
