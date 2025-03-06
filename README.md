# Nexus Network: Manual Installation Guide

This guide provides step-by-step instructions for installing and running a Nexus Network node.

## About Nexus Network

The Nexus Network is a distributed supercomputer that concentrates the world's computing power into a single blockchain. It is powered by the Nexus zkVM, with a goal to condense the entire Internet into a single proof. When you connect to the network via the Nexus App or CLI, your device becomes a node, contributing compute to the network.

The ultimate goal of Nexus is to achieve the Proof Singularity:
- Compression of all verifiable computation into a single proof
- Integration of millions of chains and applications
- Creation of a unified world computer

### Network Information

- **Chain ID**: 393
- **Native Token**: Nexus Token (NEX)
- **RPC (HTTP)**: `https://rpc.nexus.xyz/http`
- **RPC (WebSocket)**: `wss://rpc.nexus.xyz/ws`
- **Explorer**: `https://explorer.nexus.xyz`

### Hardware and VM Requirements

To run a Nexus node effectively, your system should meet these minimum requirements:

- **CPU**: Modern multi-core processor (4+ cores recommended)
- **RAM**: Minimum 4GB, 8GB+ recommended
- **Storage**: 10GB of free space
- **Network**: Stable internet connection (minimum 10 Mbps)
- **Operating System**: Linux (Ubuntu 20.04+ recommended), macOS, or Windows with WSL2

#### Running on Virtual Machines

Nexus nodes can run successfully on virtual machines with these considerations:

- Ensure your VM has dedicated CPU cores (not just shared vCPUs)
- Allocate sufficient RAM (8GB+ recommended)
- Use a VM with direct network access rather than NAT if possible


The Nexus CLI operates by:
1. Connecting to the Nexus Orchestrator to request work
2. Receiving proving tasks
3. Performing required computations
4. Submitting completed proofs back to the Orchestrator

When linked to an account, nodes earn NEX Points for their contributions, which are converted to Nexus Chain tokens hourly.



## Account Management

### Proving Modes

You have two options for proving:

1. **Link to Nexus Account (Recommended)**
   - Create an account at [app.nexus.xyz](https://app.nexus.xyz)
   - Follow the account linking instructions
   - Your contributions will earn NEX Points
   - Track your progress on the leaderboard
   - Manage all your nodes in one place

2. **Anonymous Proving**
   - No account required
   - No NEX Points earned
   - Contributions not recorded

To earn NEX Points, you must link your CLI to your Nexus account.

## Prerequisites

Before starting, ensure your system has the following dependencies:

- **Rust and Cargo**: Required for building the Nexus CLI
- **CMake**: Required for compiling certain dependencies
- **Protocol Buffers**: Required for data serialization
- **Git**: Required for cloning repositories
- **Build essentials**: Required for compilation

## Installation Steps

### 1. Install Required Dependencies

#### Ubuntu/Debian:

```bash
# Update package lists
sudo apt update
sudo apt upgrade -y

# Install essential packages
sudo apt install -y build-essential pkg-config libssl-dev git-all curl cmake protobuf-compiler
```

#### CentOS/RHEL/Fedora:

```bash
# Update system
sudo yum update -y

# Install essential packages
sudo yum install -y gcc gcc-c++ make pkgconfig openssl-devel git curl cmake protobuf-compiler
```

#### macOS:

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install cmake protobuf curl git openssl
```

### 2. Install Rust and Cargo

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add Rust to your path
source $HOME/.cargo/env

# Check if Rust is installed correctly
rustc --version
cargo --version
```

### 3. Add RISC-V Target

```bash
rustup target add riscv32i-unknown-none-elf
```

### 4. Install the Nexus CLI

There are multiple ways to install the Nexus CLI. Try these methods in order until one works:

#### Method 1: Official Installer

```bash
curl https://cli.nexus.xyz/ | sh
```

#### Method 2: Manual Download and Installation

```bash
# Create a directory for the installation
mkdir -p ~/nexus-temp
cd ~/nexus-temp

# Download the installer and inspect it
curl -s https://cli.nexus.xyz/ -o install.sh
cat install.sh  # Check what the script does
bash install.sh
```

#### Method 4: Check GitHub for Latest Release

Visit the [Nexus CLI releases page](https://github.com/nexus-xyz/nexus-cli/releases) (if available) to download the latest version manually.

### 5. Verify Installation

After installation, verify that the CLI is properly installed:

```bash
# Check if nexus-cli is in your PATH
which nexus-cli

# If not found, try to find it in common locations
find ~ -name "nexus-cli" 2>/dev/null
```

If the CLI is installed but not in your PATH, add it:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Running Your Nexus Node

### Start in the Foreground

To run the CLI in the foreground:

```bash
nexus-cli
```

When you run it for the first time, you'll need to:
1. Accept the Terms of Use
2. Choose between anonymous or linked proving

### Start in the Background

To run the CLI in the background:

```bash
# Start in the background
nohup nexus-cli > nexus.log 2>&1 &

# Check if it's running
ps aux | grep nexus-cli

# View the logs
tail -f nexus.log

# Stop the node
pkill -f nexus-cli
```

### Create a Startup Script

For easier management, create a startup script:

```bash
cat > ~/start_nexus.sh << 'EOF'
#!/bin/bash
# Start Nexus node in the background
nohup nexus-cli > $HOME/nexus.log 2>&1 &
echo "Nexus CLI started in background. Check logs with: tail -f $HOME/nexus.log"
EOF

chmod +x ~/start_nexus.sh
```

Now you can start your node with:

```bash
~/start_nexus.sh
```

### Set Up Automatic Startup

To start the node automatically on system boot:

```bash
(crontab -l 2>/dev/null; echo "@reboot $HOME/start_nexus.sh") | crontab -
```



## Troubleshooting

### Command Not Found

If you encounter "command not found" after installation:

1. Find where the binary was installed:
   ```bash
   find ~ -name "nexus-cli" 2>/dev/null
   ```

2. Create a symbolic link to a directory in your PATH:
   ```bash
   sudo ln -sf /path/to/found/nexus-cli /usr/local/bin/nexus-cli
   ```

3. Or add the directory to your PATH:
   ```bash
   echo 'export PATH="/path/to/directory:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

### Installation Fails

If installation fails:
1. Check your internet connection
2. Ensure all dependencies are properly installed
3. Check your Rust and Cargo versions
4. Try a different installation method

### Node Crashes or Disconnects

If your node crashes or disconnects:
1. Check the log file for error messages
2. Ensure your system meets the minimum requirements
3. Check your internet connection
4. Join the Discord community for support

## Additional Resources

- **Nexus Documentation**: [https://docs.nexus.xyz](https://docs.nexus.xyz)
- **Discord Community**: [https://discord.gg/nexus](https://discord.gg/nexus)
- **GitHub Repository**: [https://github.com/nexus-xyz](https://github.com/nexus-xyz)
- **Whitepaper**: [https://whitepaper.nexus.xyz](https://whitepaper.nexus.xyz)



---

**Note**: This guide was created by [Bokiko](https://github.com/bokiko) for the Cloudiko.io community.
