#!/usr/bin/bash

# install nushell
sudo apt install wget

wget -qO- https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/fury-nushell.gpg
echo "deb [signed-by=/etc/apt/keyrings/fury-nushell.gpg] https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury-nushell.list
sudo apt update
sudo apt install nushell

# Add nushell to shells list
echo "$(which nu)" | sudo tee -a /etc/shells

# Change shell to nushell on root and current user
sudo chsh -s $(which nu)
chsh -s $(which nu)
