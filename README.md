# nixos-config

My personal NixOS config

## Apply to a Fresh NixOS Installation

1. Add the new machine to `machines` folder in this repo if needed
2. Install the host ssh key into `/etc/ssh/ssh_host_ed25519_key`
3. Run script below. (change environment variables accordingly)

```sh
export HOST=nuc11

sudo su
rm /etc/nix/nix.conf
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
mv /etc/nixos /etc/nixos.bak
cd /etc
nix-shell --package git --command "git clone https://github.com/kokobd/nixos-config.git"
nixos-rebuild switch --flake .#HOST
```
