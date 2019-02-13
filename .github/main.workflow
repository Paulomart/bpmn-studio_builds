workflow "New workflow" {
  on = "issue_comment"
  resolves = [
    "move",
    "build",
  ]
}

action "init" {
  uses = "docker://alpine/git"
  args = "init"
}

action "add origin" {
  uses = "docker://alpine/git"
  needs = ["init"]
  args = "remote add origin https://github.com/process-engine/bpmn-studio.git"
}

action "pull" {
  uses = "docker://alpine/git"
  needs = ["add origin"]
  args = "pull origin master"
}

action "move" {
  uses = "docker://bash"
  needs = ["pull"]
  runs = "echo hi"
}

action "install" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "install"
  needs = ["move"]
}

action "build" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "build"
  needs = ["install"]
}
