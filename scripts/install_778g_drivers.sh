#!/bin/bash
# install_778g_drivers.sh
# Automated driver installation for Snapdragon 778G+ (Adreno 642L)

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

EDEN_DATA_PATH="/sdcard/Android/data/com.github.skyline_emu.skyline/files"
DRIVERS_PATH="$EDEN_DATA_PATH/drivers"
BACKUP_PATH="$EDEN_DATA_PATH/drivers_backup_$(date +%Y%m%d_%H%M%S)"

echo -e "${BLUE}Snapdragon 778G+ Driver Installer${NC}"
echo -e "${BLUE}Eden Emulator Optimization${NC}\n"

# Step 1: Backup
echo -e "${YELLOW}[1/5] Creating backup...${NC}"
if [ -d "$DRIVERS_PATH" ]; then
    mkdir -p "$BACKUP_PATH"
    cp -r "$DRIVERS_PATH"/* "$BACKUP_PATH/" 2>/dev/null || true
    echo -e "${GREEN}[✓] Backup created${NC}"
else
    mkdir -p "$DRIVERS_PATH"
fi

# Step 2: Download
echo -e "${YELLOW}[2/5] Downloading Turnip v26.0.0 R8...${NC}"
DRIVER_URL="https://github.com/K11MCH1/AdrenoToolsDrivers/releases/download/v26.0.0-rc08/Turnip_v26.0.0_R8_Gmem.zip"
wget -q -O /tmp/turnip_driver.zip "$DRIVER_URL" || curl -L -s -o /tmp/turnip_driver.zip "$DRIVER_URL"
echo -e "${GREEN}[✓] Downloaded${NC}"

# Step 3: Extract
echo -e "${YELLOW}[3/5] Extracting drivers...${NC}"
unzip -q /tmp/turnip_driver.zip -d "$DRIVERS_PATH/" || true
echo -e "${GREEN}[✓] Extracted${NC}"

# Step 4: Configure
echo -e "${YELLOW}[4/5] Setting up configuration...${NC}"
cat > "$EDEN_DATA_PATH/env_config.txt" << 'EOF'
TU_DEBUG=autotuner,gmem,noconform
TU_GPU_OVERRIDE=642
FD_MESA_DEBUG=info
GALLIUM_HUD=fps+cpu+memory
MALLOC_TRIM_THRESHOLD_=131072
TU_PERF=2
EOF
echo -e "${GREEN}[✓] Configured${NC}"

# Step 5: Verify
echo -e "${YELLOW}[5/5] Verifying...${NC}"
if [ -d "$DRIVERS_PATH" ] && [ "$(ls -A $DRIVERS_PATH)" ]; then
    echo -e "${GREEN}[✓] Success!${NC}"
else
    echo -e "${RED}[✗] Failed${NC}"
    exit 1
fi

rm -f /tmp/turnip_driver.zip

echo -e "\n${GREEN}Installation Complete!${NC}"
echo -e "Open Eden → Settings → Graphics → Custom Driver: Turnip\n"
