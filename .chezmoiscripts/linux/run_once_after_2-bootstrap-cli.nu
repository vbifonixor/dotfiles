# install mise
curl https://mise.run | sh

# install starship
curl -sS https://starship.rs/install.sh | sh

# activate mise
mise activate nu | save $"~/.config/nushell/mise.gen.nu" -f
