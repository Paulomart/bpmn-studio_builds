workflow "New workflow" {
  on = "issue_comment"
  resolves = [
    "move",
    "build",
  ]
}

action "checkout" {
  uses = "docker://alpine/git"
  args = "clone https://github.com/process-engine/bpmn-studio.git"
}

action "move" {
  uses = "actions/bin/sh@master"
  args = "mv bpmn-studio/* ."
  needs = ["checkout"]
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
