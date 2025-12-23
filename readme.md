[Do this first](https://github.com/Schniz/fnm/issues/338)

# Powershell: installing scoop

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri <https://get.scoop.sh> | Invoke-Expression

# Prerequisites

scoop install git;
scoop install nu;
scoop install chezmoi;

# Thorax initialization

```nushell
scoop install rclone;

scoop bucket add nonportable;

scoop install winfsp-np;

rclone config create Thorax-dav webdav url=<http://192.168.1.95:3923> vendor=owncloud pacer_min_sleep=0.01ms user=k pass=h31mdall;

scoop install nssm;
```

On Administrator terminal:

```nu
nssm install thorax (which rclone | get 0.path)
nssm set thorax AppParameters "mount --vfs-cache-mode writes --dir-cache-time 5s Thorax-dav: W:"
nssm set thorax AppDirectory (which rclone | get 0.path | path dirname)
nssm set thorax AppExit Default Restart
nssm set thorax AppNoConsole 1
nssm set thorax DisplayName thorax
nssm set thorax ObjectName LocalSystem
nssm set thorax Start SERVICE_AUTO_START
nssm set thorax Type SERVICE_WIN32_OWN_PROCESS
```

# Applying this dotfiles repo

chezmoi init --apply vbifonixor
scoop install servy

# Set up kanata

Do after kanata is updated on scoop. For 1.10.1 it so far only works manually.
This script creates a windows shortcut for kanata binary, puts it into programs folder in the start menu and assigns it a shortcut of Alt+Ctrl+Shift+K.

For manual shortcut you need to set it up like this (replace nushell evals with their results):

```json
{
  "TargetPath": "(which conhost | get 0.path | path expand)",
  "Arguments": "--headless (which kanata | get 0.path | path expand) --cfg=(ls ~/.config/kanata/kanata.kbd | get 0.name | path expand)",
  "WorkingDirectory": "(which kanata | get 0.path | path dirname)",
  "WindowStyle": 7,
  "Hotkey": "Alt+Ctrl+Shift+K"
}
```

```nu
let cfg = $"
{
  \"TargetPath\": \"(which conhost | get 0.path | path expand)\",
  \"Arguments\": \"--headless (which kanata | get 0.path | path expand) --cfg=(ls ~/.config/kanata/kanata.kbd | get 0.name | path expand)\",
  \"WorkingDirectory\": \"(which kanata | get 0.path |  path dirname)\",
  \"WindowStyle\": 7,
  \"Hotkey\": "Alt+Ctrl+Shift+K"
}
"

let newLink = "~/AppData/Roaming/Microsoft/Windows/Start Menu/kanata.lnk"

let ps_script = $"
    $sh = New-Object -ComObject WScript.Shell
    $s = $sh.CreateShortcut\('( $newLink | path expand )'\)
    $s.TargetPath = '($cfg.TargetPath)'
    $s.Arguments = '($cfg.Arguments)'
    $s.WorkingDirectory = '($cfg.WorkingDirectory)'
    $s.WindowStyle = ($cfg.WindowStyle)
    $s.Save\(\)
"
powershell -Command $ps_script

```
