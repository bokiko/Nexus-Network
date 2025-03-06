#!/bin/bash

# Nexus Network Onboarding Script
# This script automates the setup process for the Nexus Network
# Created for Cloudiko.io

# Text formatting
BOLD="\e[1m"
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Function to display section headers
print_header() {
    echo -e "\n${BOLD}${BLUE}=== $1 ===${RESET}\n"
}

# Function to display success messages
print_success() {
    echo -e "${GREEN}✓ $1${RESET}"
}

# Function to display info messages
print_info() {
    echo -e "${YELLOW}ℹ $1${RESET}"
}

# Function to display error messages
print_error() {
    echo -e "${RED}✗ $1${RESET}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if running in tmux
in_tmux() {
    [ -n "$TMUX" ]
}

# Display welcome message
clear
echo -e "${BOLD}${BLUE}"
echo "  _   _                       _   _      _                      _    "
echo " | \ | | _____  ___   _ ___  | \ | | ___| |___      _____  _ __| | __"
echo " |  \| |/ _ \ \/ / | | / __| |  \| |/ _ \ __\ \ /\ / / _ \| '__| |/ /"
echo " | |\  |  __/>  <| |_| \__ \ | |\  |  __/ |_ \ V  V / (_) | |  |   < "
echo " |_| \_|\___/_/\_\\__,_|___/ |_| \_|\___|\__| \_/\_/ \___/|_|  |_|\_\\"
echo -e "${RESET}"
echo -e "Welcome to the Nexus Network Onboarding Script"
echo -e "This script will guide you through setting up your Nexus node"
echo -e "and contributing to the network."
echo

# Check if running in tmux
if ! in_tmux; then
    print_info "Starting tmux session for persistence..."
    # Create a new tmux session and run this script inside it
    tmux new-session -d -s nexus
    tmux send-keys -t nexus "bash $(realpath $0)" C-m
    tmux attach -t nexus
    exit 0
fi

# Display system information
print_header "System Information"
echo "OS: $(uname -s)"
echo "CPU: $(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ':' -f 2 | sed 's/^[ \t]*//')"
echo "Memory: $(free -h | grep Mem | awk '{print $2}')"
echo "Disk Space: $(df -h / | awk 'NR==2 {print $4}') available"
echo

# Check for prerequisites
print_header "Checking Prerequisites"

# Check for curl
if command_exists curl; then
    print_success "curl is installed"
else
    print_error "curl is not installed"
    echo "Installing curl..."
    sudo apt-get update && sudo apt-get install -y curl
fi

# Check for tmux
if command_exists tmux; then
    print_success "tmux is installed"
else
    print_error "tmux is not installed"
    echo "Installing tmux..."
    sudo apt-get update && sudo apt-get install -y tmux
fi

# Check for nano
if command_exists nano; then
    print_success "nano is installed"
else
    print_error "nano is not installed"
    echo "Installing nano..."
    sudo apt-get update && sudo apt-get install -y nano
fi

# Check for Rust
if command_exists rustc; then
    print_success "Rust is installed ($(rustc --version))"
else
    print_info "Rust is not installed. Installing now..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
    print_success "Rust installed successfully"
fi

# Check for CMake
if command_exists cmake; then
    print_success "CMake is installed ($(cmake --version | head -n 1))"
else
    print_info "CMake is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y cmake
    print_success "CMake installed successfully"
fi

# Check for protocol buffers
if command_exists protoc; then
    print_success "Protocol Buffers is installed ($(protoc --version))"
else
    print_info "Protocol Buffers is not installed. Installing now..."
    sudo apt-get update && sudo apt-get install -y protobuf-compiler
    print_success "Protocol Buffers installed successfully"
fi

# Add RISC-V target
print_info "Adding RISC-V target for Rust..."
rustup target add riscv32i-unknown-none-elf
print_success "RISC-V target added successfully"

# Ask user if they want to use the Quick Install or Manual Installation
print_header "Installation Options"
echo "1) Quick Install (Recommended)"
echo "2) Manual Installation"
read -p "Enter your choice (1 or 2): " install_choice

if [ "$install_choice" = "1" ]; then
    print_header "Installing Nexus CLI"
    print_info "Running quick install script..."
    curl https://cli.nexus.xyz/ | sh
    if [ $? -eq 0 ]; then
        print_success "Nexus CLI installed successfully"
    else
        print_error "Failed to install Nexus CLI"
        exit 1
    fi
else
    print_header "Manual Installation"
    print_info "Installing system dependencies..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y build-essential pkg-config libssl-dev git-all
    print_success "System dependencies installed"
    
    print_info "Installing Nexus CLI manually..."
    # Here you would place manual installation steps
    # This is a placeholder for the actual manual installation process
    print_info "Manual installation requires specific steps based on your system."
    print_info "Please refer to the official documentation for detailed instructions."
fi

# Setup and Configuration
print_header "Setup & Configuration"
print_info "To set up your Nexus CLI, you need to:"
echo "1. Run the CLI for the first time"
echo "2. Accept the Terms of Use"
echo "3. Choose between anonymous or linked proving"
echo

# Display information about proving modes
print_header "Proving Modes"
echo "You have two options for proving:"
echo
echo "1) Link to Nexus Account (Recommended)"
echo "   - Create an account at app.nexus.xyz"
echo "   - Follow the account linking instructions"
echo "   - Your contributions will earn NEX Points"
echo "   - Track your progress on the leaderboard"
echo "   - Manage all your nodes in one place"
echo
echo "2) Anonymous Proving"
echo "   - No account required"
echo "   - No NEX Points earned"
echo "   - Contributions not recorded"
echo
print_info "To earn NEX Points, you must link your CLI to your Nexus account."
echo

# Ask if user has a Nexus account
read -p "Do you already have a Nexus account? (y/n): " has_account

if [ "$has_account" = "n" ]; then
    print_info "Please create an account at https://app.nexus.xyz before continuing."
    print_info "This will allow you to earn NEX Points for your contributions."
    read -p "Press Enter once you have created an account..."
fi

# Setup automatic node startup
print_header "Automatic Node Startup"
print_info "Setting up automatic startup for Nexus node when system reboots..."

# Create the startup script
cat > $HOME/start_nexus.sh << 'EOF'
#!/bin/bash
# Start Nexus node in a tmux session
if ! tmux has-session -t nexus 2>/dev/null; then
    tmux new-session -d -s nexus
    tmux send-keys -t nexus "nexus-cli" C-m
fi
EOF

chmod +x $HOME/start_nexus.sh

# Create crontab entry
(crontab -l 2>/dev/null; echo "@reboot $HOME/start_nexus.sh") | crontab -

print_success "Automatic startup configured"

# Extracting node IP
print_header "Node IP Information"
PUBLIC_IP=$(curl -s https://api.ipify.org)
print_info "Your node's public IP address: $PUBLIC_IP"
echo "You may need this information when managing your node on the Nexus website."

# Final instructions
print_header "Getting Started"
print_info "To start your Nexus node, run the following command:"
echo "nexus-cli"
echo
print_info "To check the status of your node, you can connect to the tmux session:"
echo "tmux attach -t nexus"
echo
print_info "To detach from the tmux session without stopping your node, press:"
echo "CTRL+B, then D"
echo

print_header "Network Information"
echo "Chain ID: 393"
echo "Native Token: Nexus Token (NEX)"
echo "RPC (HTTP): https://rpc.nexus.xyz/http"
echo "RPC (WebSocket): wss://rpc.nexus.xyz/ws"
echo "Explorer: https://explorer.nexus.xyz"
echo

print_header "Additional Resources"
echo "Nexus Documentation: https://docs.nexus.xyz"
echo "Discord Community: https://discord.gg/nexus"
echo "GitHub Repository: https://github.com/nexus-xyz"
echo "Whitepaper: https://whitepaper.nexus.xyz"
echo

print_success "Onboarding script completed successfully!"
echo "You are now ready to contribute to the Nexus Network."
echo "Thank you for being part of the Nexus ecosystem!"
