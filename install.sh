#!/bin/bash

# Installation script for aptos-curl
# Usage: curl -fsSL https://raw.githubusercontent.com/your-repo/aptos-curl/main/install.sh | bash

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_info() {
    echo -e "${BLUE}$1${NC}"
}

print_warning() {
    echo -e "${YELLOW}$1${NC}"
}

# Default installation directory
INSTALL_DIR="/usr/local/bin"
SCRIPT_NAME="aptos-curl"
REPO_URL="https://raw.githubusercontent.com/your-repo/aptos-curl/main/aptos-curl"

echo ""
print_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
print_info "  aptos-curl installer"
print_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if running with sufficient privileges
if [ ! -w "$INSTALL_DIR" ]; then
    print_warning "You may need sudo privileges to install to $INSTALL_DIR"
    SUDO="sudo"
else
    SUDO=""
fi

# Check dependencies
print_info "Checking dependencies..."
missing_deps=()

if ! command -v curl &> /dev/null; then
    missing_deps+=("curl")
fi

if ! command -v aptos &> /dev/null; then
    missing_deps+=("aptos")
fi

if ! command -v jq &> /dev/null; then
    missing_deps+=("jq")
fi

if [ ${#missing_deps[@]} -gt 0 ]; then
    print_error "Missing required dependencies: ${missing_deps[*]}"
    echo ""
    echo "Please install them first:"
    echo ""

    for dep in "${missing_deps[@]}"; do
        case "$dep" in
            aptos)
                echo "  Aptos CLI: https://aptos.dev/tools/aptos-cli/"
                ;;
            jq)
                echo "  jq: https://jqlang.github.io/jq/download/"
                echo "    macOS: brew install jq"
                echo "    Ubuntu/Debian: sudo apt-get install jq"
                ;;
            curl)
                echo "  curl: Usually pre-installed on most systems"
                ;;
        esac
    done

    exit 1
fi

print_success "✓ All dependencies found"
echo ""

# Download and install
print_info "Installing aptos-curl to $INSTALL_DIR..."

# Download the script
if ! curl -fsSL "$REPO_URL" -o "/tmp/$SCRIPT_NAME" 2>/dev/null; then
    print_error "Failed to download aptos-curl from $REPO_URL"
    echo ""
    echo "If you're installing from a local copy, you can manually install by running:"
    echo "  sudo cp aptos-curl $INSTALL_DIR/aptos-curl"
    echo "  sudo chmod +x $INSTALL_DIR/aptos-curl"
    exit 1
fi

# Install the script
$SUDO mv "/tmp/$SCRIPT_NAME" "$INSTALL_DIR/$SCRIPT_NAME"
$SUDO chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

print_success "✓ Successfully installed aptos-curl"
echo ""

# Verify installation
if command -v aptos-curl &> /dev/null; then
    VERSION=$(aptos-curl --version 2>/dev/null || echo "unknown")
    print_success "Installation verified: $VERSION"
else
    print_warning "Installation completed but aptos-curl is not in PATH"
    echo "You may need to add $INSTALL_DIR to your PATH"
fi

echo ""
print_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
print_success "Installation complete!"
print_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Usage: aptos-curl -a <ADDRESS> -o <OUTPUT_DIR>"
echo "Help:  aptos-curl --help"
echo ""
