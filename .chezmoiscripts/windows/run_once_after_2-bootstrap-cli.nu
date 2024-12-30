scoop install starship

# Change to scoop install mise after pr is merged into scoop
# https://github.com/ScoopInstaller/Main/pull/6374
cargo-binstall mise


# Install mise
mise activate nu | save "~/.config/nushell/mise.gen.nu" -f
