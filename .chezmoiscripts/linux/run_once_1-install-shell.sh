#!/usr/bin/bash

# Update PPAs
sudo apt update

# Install build dependencies
sudo apt install -y pkg-config libssl-dev build-essential

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add cargo to PATH
source ~/.cargo/env

# Install nushell
cargo install nu@0.101.0 --locked

# Add nushell to shells list
echo "$(which nu)" | sudo tee -a /etc/shells

# Change shell to nushell on root and current user
sudo chsh -s $(which nu)
chsh -s $(which nu)
