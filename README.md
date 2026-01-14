# dcli-perkedel

Declarative package management configuration for Arch Linux.

This dotfiles is used internally for Perkedel offices. You are free to also use this as well.

## Structure

- `config.yaml` - Main configuration file
- `packages/base.yaml` - Base packages for all machines
- `packages/hosts/` - Host-specific package configurations
- `packages/modules/` - Optional package modules
- `scripts/` - Post-install hook scripts
- `udev-rules/` - Custom udev rules
- `state/` - Auto-generated state files (git-ignored)

## Usage

### Add base packages
Edit `packages/base.yaml` to add packages that should be installed on all machines.

### Add host-specific packages
Edit `packages/hosts/joelwindows7-endeavour-dcli.json` to add packages specific to this machine.

### Create and enable modules
1. Create a new JSON file in `packages/modules/`
2. Enable it with: `dcli module enable <module-name>` OR edit `config.yaml` and add `<module-name>` into section `enabled-modules` list.
3. Sync packages: `dcli sync`

### Sync packages
```bash
dcli sync           # Preview and install missing packages
dcli sync --prune   # Also remove packages not in configuration
```

## Git Integration

Initialize a git repository to track your configuration:

```bash
cd ~/.config/arch-config
git init
git add .
git commit -m "Initial arch-config setup"
```

The `state/installed.yaml` file is auto-generated and git-ignored.

### Updating Git

Update this arch-config repo with:

#### Uploading from editing source

```bash
cd ~/.config/arch-config # & do edit some stuffs there!
dcli repo push  # Type your commit message when prompted & enter
```

#### Download from Git repository

```bash
cd ~/.config/arch-config # optional, just in case you wanna check first
dcli repo pull
dcli sync  # then review what will be installed, and confirm.
```
#### Download to another computer

Setup DCLI over there, & then repo clone this using the DCLI interface

```bash
git clone https://gitlab.com/theblackdon/dcli
cd dcli
chmod +x ./install.sh # to make sure this file has execute permission
./install.sh # yes yes yes to recommended configs

# Prepare
dcli repo clone # & follow interactive prompt: URL of Git source, etc.
```

## More Resources

- https://gitlab.com/theblackdon/dcli . Main resource of DCLI. DCLI is a Package Declarator system for Arch Linux and derivatives, inspired by Nix & NixOS.
- https://gitlab.com/theblackdon/arch-config . Sample config of the DCLI. Black Don's personal config you can learn & reference from.
