def "nu-complete zjtab projects" [] {
    let home = ($env.HOME | default "~" | path expand)
    let reg_paths = [
        ($home | path join ".config/zellij/project-registry.toml")
        ($home | path join ".config/zellij/project-registry.example.toml")
    ]

    let reg_path = ($reg_paths | where {|p| ($p | path exists)} | get 0? | default "")
    if ($reg_path | is-empty) {
        []
    } else {
        try {
            let reg = (open --raw $reg_path | from toml)
            ($reg.project? | default [] | get name? | flatten | uniq)
        } catch {
            []
        }
    }
}

export extern "zjtab" [
    --project(-p): string@"nu-complete zjtab projects"
    --branch(-b): string
    --registry: string
    --no-close
]

