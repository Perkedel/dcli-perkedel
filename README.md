# dcli-perkedel

Declarative package management configuration for Arch Linux.

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
2. Enable it with: `dcli module enable <module-name>`
3. Sync packages: `dcli sync`

### Sync packages
```bash
dcli sync           # Preview and install missing packages
dcli sync --prune   # Also remove packages not in configuration
```

## Git Integration

Initialize a git repository to track your configuration:

```bash
cd /home/joelwindows7/.config/arch-config
git init
git add .
git commit -m "Initial arch-config setup"
```

The `state/installed.yaml` file is auto-generated and git-ignored.

### Updating Git

Update this arch-config repo with:

#### Uploading from editing source

```bash
cd ~/.config/arch-config
dcli repo push  # Type your commit message when prompted & enter
```

#### Download from Git repository

```bash
cd ~/.config/arch-config
dcli repo pull
dcli sync  # then review what will be installed, and confirm.
```

## More Resources

- https://gitlab.com/theblackdon/dcli . Main resource of DCLI. DCLI is a Package Declarator system for Arch Linux and derivatives, inspired by Nix & NixOS.
- https://gitlab.com/theblackdon/arch-config . Sample config of the DCLI. Black Don's personal config you can learn & reference from.
