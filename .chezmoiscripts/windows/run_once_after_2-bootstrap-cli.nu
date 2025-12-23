scoop bucket add extras;
scoop bucket add nerd-fonts;

scoop install starship;
scoop install mise;
scoop install extras/vscode;
scoop install extras/vivaldi;
scoop install telegram;
scoop install nerd-fonts/JetBrainsMono-NF;
scoop install main/gnupg;
scoop install extras/bitwarden;
scoop install powertoys;

# Install mise
mise activate nu | save "~/.config/nushell/mise.gen.nu" -f
