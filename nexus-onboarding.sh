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

# Display system information
print_header "System Information"
echo "OS: $(uname -s)"
if [ -f /proc/cpuinfo ]; then
    echo "CPU: $(grep "model name" /proc/cpuinfo | head -n 1 | cut -d ':' -f 2 | sed 's/^[ \t]*//' || echo "Unknown")"
else
    echo "CPU: Unable to determine"
fi
if command_exists free; then
    echo "Memory: $(free -h | grep Mem | awk '{print $2}' || echo "Unknown")"
else
    echo "Memory: Unable to determine"
fi
if command_exists df; then
    echo "Disk Space: $(df -h / | awk 'NR==2 {print $4}' || echo "Unknown") available"
else
    echo "Disk Space: Unable to determine"
fi
echo

# Check for prerequisites
print_header "Checking Prerequisites"

# Check for curl
if command_exists curl; then
    print_success "curl is installed"
else
    print_error "curl is not installed"
    echo "Installing curl..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y curl
    elif command_exists yum; then
        sudo yum install -y curl
    elif command_exists brew; then
        brew install curl
    else
        print_error "Unable to install curl. Please install it manually."
        exit 1
    fi
fi

# Check for tmux
if command_exists tmux; then
    print_success "tmux is installed"
else
    print_error "tmux is not installed"
    echo "Installing tmux..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y tmux
    elif command_exists yum; then
        sudo yum install -y tmux
    elif command_exists brew; then
        brew install tmux
    else
        print_error "Unable to install tmux. Please install it manually."
    fi
fi

# Check for nano
if command_exists nano; then
    print_success "nano is installed"
else
    print_error "nano is not installed"
    echo "Installing nano..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y nano
    elif command_exists yum; then
        sudo yum install -y nano
    elif command_exists brew; then
        brew install nano
    else
        print_error "Unable to install nano. Please install it manually."
    fi
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
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y cmake
    elif command_exists yum; then
        sudo yum install -y cmake
    elif command_exists brew; then
        brew install cmake
    else
        print_error "Unable to install CMake. Please install it manually."
    fi
    print_success "CMake installed successfully"
fi

# Check for protocol buffers
if command_exists protoc; then
    print_success "Protocol Buffers is installed ($(protoc --version))"
else
    print_info "Protocol Buffers is not installed. Installing now..."
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y protobuf-compiler
    elif command_exists yum; then
        sudo yum install -y protobuf-compiler
    elif command_exists brew; then
        brew install protobuf
    else
        print_error "Unable to install Protocol Buffers. Please install it manually."
    fi
    print_success "Protocol Buffers installed successfully"
fi

# Add RISC-V target
print_info "Adding RISC-V target for Rust..."
if command_exists rustup; then
    rustup target add riscv32i-unknown-none-elf
    print_success "RISC-V target added successfully"
else
    print_error "rustup not found. Please make sure Rust is installed correctly."
fi

# Make sure the PATH includes cargo
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
    print_success "Cargo environment loaded"
fi

# Installing Nexus CLI
print_header "Installing Nexus CLI"
print_info "Downloading and installing Nexus CLI..."

# Ensure we have a directory for binaries
if [ ! -d "$HOME/.local/bin" ]; then
    mkdir -p "$HOME/.local/bin"
    print_info "Created $HOME/.local/bin directory"
fi

# Add local bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    export PATH="$HOME/.local/bin:$PATH"
    print_info "Added $HOME/.local/bin to PATH"
fi

# Download and install the CLI directly
curl -sL https://cli.nexus.xyz/download | tar xz -C "$HOME/.local/bin"
chmod +x "$HOME/.local/bin/nexus-cli"
print_success "Nexus CLI installed at $HOME/.local/bin/nexus-cli"

# Verify installation
if command_exists nexus-cli; then
    print_success "Nexus CLI installed successfully!"
    NEXUS_CLI_PATH=$(which nexus-cli)
    print_info "Nexus CLI path: $NEXUS_CLI_PATH"
else
    print_error "Nexus CLI installation verification failed"
    print_info "Creating a symbolic link..."
    ln -sf "$HOME/.local/bin/nexus-cli" /usr/local/bin/nexus-cli 2>/dev/null || sudo ln -sf "$HOME/.local/bin/nexus-cli" /usr/local/bin/nexus-cli
    
    if command_exists nexus-cli; then
        print_success "Nexus CLI symlink created successfully!"
    else
        print_error "Failed to create symlink. You may need to restart your shell or run: source ~/.bashrc"
        print_info "You can run Nexus CLI directly using: $HOME/.local/bin/nexus-cli"
    fi
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

# Define the CLI path for the scripts
if command_exists nexus-cli; then
    CLI_PATH=$(which nexus-cli)
else
    CLI_PATH="$HOME/.local/bin/nexus-cli"
fi

# Setup startup instructions - without using tmux
print_header "Manual Node Startup"
print_info "To run your Nexus node in the background, use these commands:"
echo 
echo "Start the node in the background:"
echo "nohup $CLI_PATH > nexus.log 2>&1 &"
echo
echo "Check if it's running:"
echo "ps aux | grep nexus-cli"
echo
echo "View the log:"
echo "tail -f nexus.log"
echo
echo "Stop the node:"
echo "pkill -f nexus-cli"
echo

# Create a simple startup script
cat > $HOME/start_nexus.sh << EOF
#!/bin/bash
# Start Nexus node in the background
nohup $CLI_PATH > \$HOME/nexus.log 2>&1 &
echo "Nexus CLI started in background. Check logs with: tail -f \$HOME/nexus.log"
EOF

chmod +x $HOME/start_nexus.sh

print_info "A startup script has been created at $HOME/start_nexus.sh"
print_info "You can run it with: ./start_nexus.sh"

# Add to crontab if available
if command_exists crontab; then
    read -p "Would you like to start Nexus automatically on reboot? (y/n): " auto_start
    if [ "$auto_start" = "y" ]; then
        (crontab -l 2>/dev/null; echo "@reboot $HOME/start_nexus.sh") | crontab -
        print_success "Automatic startup configured"
    fi
fi

# Extracting node IP
print_header "Node IP Information"
if command_exists curl; then
    PUBLIC_IP=$(curl -s https://api.ipify.org 2>/dev/null || echo "Unable to determine")
    print_info "Your node's public IP address: $PUBLIC_IP"
    echo "You may need this information when managing your node on the Nexus website."
else
    print_error "curl not found. Unable to determine public IP address."
fi

# Final instructions
print_header "Getting Started"
print_info "To start your Nexus node, run the following command:"
echo "$CLI_PATH"
echo
print_info "Or to run it in the background:"
echo "./start_nexus.sh"
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

# Let the user know they may need to restart their shell
print_info "NOTE: If the 'nexus-cli' command is not found, please try:"
echo "1. Restart your terminal session"
echo "2. Run: source ~/.bashrc"
echo "3. Or use the full path: $CLI_PATH"
