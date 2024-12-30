export def "current-git-branch" [] {
    git branch
    | find "*"
    | get 0
    | into string
    | ansi strip
    | str replace "*" ""
    | str trim
}
