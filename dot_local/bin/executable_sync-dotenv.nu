#!/usr/bin/env nu

def log [verbose: bool, msg: string] {
  if $verbose {
    print -e $msg
  }
}

def main [
  --verbose(-v)
] {
  let git_dir = (^git rev-parse --path-format=absolute --git-common-dir | str trim)
  let dotenv = (^mise -C $git_dir env --dotenv)

  log $verbose $"[sync-dotenv] git_dir=($git_dir)"
  log $verbose $"[sync-dotenv] generated dotenv bytes=($dotenv | str length)"

  let worktrees = (
    ^git --git-dir $git_dir worktree list --porcelain
    | lines
    | where $it starts-with 'worktree '
    | each { |line| ($line | str replace -r '^worktree\s+' '') }
  )

  log $verbose $"[sync-dotenv] found worktrees=($worktrees | length)"

  for wt in $worktrees {
    log $verbose $"[sync-dotenv] worktree=($wt)"
    let dotgit = ($wt | path join '.git')
    if not ($dotgit | path exists) {
      log $verbose $"[sync-dotenv] skip: missing ($dotgit)"
      continue
    }

    let out = ($wt | path join '.env')
    let tmp = ($wt | path join '.env.tmp')

    log $verbose $"[sync-dotenv] write tmp=($tmp)"
    ($dotenv + "\n") | save --force $tmp
    ^chmod 600 $tmp
    log $verbose $"[sync-dotenv] move to out=($out)"
    mv --force $tmp $out
  }
}

