# Define the URL and destination
let url = "https://github.com/dj95/zjstatus/releases/download/v0.23.0/zjstatus.wasm"
let dest_dir = ("~/.config/zellij/" | path expand)
let dest_file = ($dest_dir | path join "zjstatus.wasm")

# Ensure the directory exists
if not ($dest_dir | path exists) {
    print $"Creating directory: ($dest_dir)"
    mkdir $dest_dir
}

# Download the file
print $"Downloading zjstatus.wasm to ($dest_dir)..."

# Using --raw is important for binary files like .wasm
http get --raw $url | save --force $dest_file

print "Done!"