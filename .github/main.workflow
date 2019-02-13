workflow "New workflow" {
  on = "issue_comment"
  resolves = [
    "move",
    "build",
  ]
}


action "move" {
  uses = "docker://bash"
  runs = "rm -fr .git"
}

action "init" {
  uses = "docker://alpine/git"
  needs = ["move"]
  args = "init"
}

action "add origin" {
  uses = "docker://alpine/git"
  needs = ["init"]
  args = "remote add bpmnstudio https://github.com/process-engine/bpmn-studio.git"
}

action "pull" {
  uses = "docker://alpine/git"
  needs = ["add origin"]
  args = "pull bpmnstudio master"
}

action "install" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "install"
  needs = ["pull"]
}

action "build" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  args = "build"
  needs = ["install"]
}
