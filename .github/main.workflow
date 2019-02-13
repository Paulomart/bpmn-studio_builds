workflow "New workflow" {
  on = "issue_comment"
  resolves = ["GitHub Action for npm"]
}

action "docker://alpine/git" {
  uses = "docker://alpine/git"
  args = "init && git remote add -t \\* -f origin https://github.com/process-engine/bpmn-studio.git && git checkout master"
}

action "build" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  needs = ["docker://alpine/git"]
  args = "install"
}

action "GitHub Action for npm" {
  uses = "actions/npm@4633da3702a5366129dca9d8cc3191476fc3433c"
  needs = ["build"]
  args = "build"
}
