#!/usr/bin/env bash
# Install udev rules for controller support
# Part of arch-config declarative package management

# Black Don https://gitlab.com/theblackdon/arch-config/-/blob/main/scripts/install-controller-udev-rules.sh

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

UDEV_RULES_DIR="/etc/udev/rules.d"
ARCH_CONFIG_DIR="${ARCH_CONFIG_DIR:-/home/${SUDO_USER:-$USER}/.config/arch-config}"
SOURCE_RULES="${ARCH_CONFIG_DIR}/udev-rules/60-controller-support.rules"
DEST_RULES="${UDEV_RULES_DIR}/60-controller-support.rules"

echo -e "${BLUE}Installing controller udev rules...${NC}"

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Error: This script must be run with sudo${NC}" >&2
  echo "Usage: sudo $0" >&2
  exit 1
fi

# Check if source rules file exists
if [ ! -f "$SOURCE_RULES" ]; then
  echo -e "${RED}Error: Source rules file not found: $SOURCE_RULES${NC}" >&2
  exit 1
fi

# Create udev rules directory if it doesn't exist
if [ ! -d "$UDEV_RULES_DIR" ]; then
  echo -e "${YELLOW}Creating udev rules directory: $UDEV_RULES_DIR${NC}"
  mkdir -p "$UDEV_RULES_DIR"
fi

# Copy rules file
echo -e "${BLUE}Copying udev rules to $DEST_RULES${NC}"
cp "$SOURCE_RULES" "$DEST_RULES"
chmod 644 "$DEST_RULES"

# Reload udev rules
echo -e "${BLUE}Reloading udev rules...${NC}"
udevadm control --reload-rules

# Trigger udev to apply rules to existing devices
echo -e "${BLUE}Triggering udev to apply rules...${NC}"
udevadm trigger

# Load uinput kernel module if not already loaded
echo -e "${BLUE}Loading uinput kernel module...${NC}"
if ! lsmod | grep -q "^uinput"; then
  modprobe uinput
fi

# Ensure uinput module loads on boot
MODULES_LOAD_FILE="/etc/modules-load.d/controller-support.conf"
if [ ! -f "$MODULES_LOAD_FILE" ]; then
  echo -e "${BLUE}Configuring kernel modules to load on boot...${NC}"
  cat > "$MODULES_LOAD_FILE" << EOF
# Controller support kernel modules
# Managed by arch-config controller-support module
uinput
EOF
fi

echo ""
echo -e "${GREEN}✓ Controller udev rules installed successfully!${NC}"
echo ""
echo -e "${BLUE}Installed files:${NC}"
echo "  - $DEST_RULES"
echo "  - $MODULES_LOAD_FILE"
echo ""
echo -e "${BLUE}Note:${NC} Controllers should now be accessible to all users."
echo "If you have controllers currently connected, you may need to unplug"
echo "and replug them for the new rules to take effect."
echo ""

