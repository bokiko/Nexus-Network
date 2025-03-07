# Nexus Network Node Installation Guide

> **NOTE:** Testnet II is over. Devnet mode is live.

## What is Nexus Network?

The Nexus Network is a distributed supercomputer that concentrates computing power into a single blockchain. By running a node, you contribute to this network and can earn NEX Points.

## System Requirements

### Minimum Requirements
- **CPU**: 4 cores
- **RAM**: 8GB (will use swap if available)
- **Storage**: 10GB free space
- **Network**: Stable internet connection

### Recommended Requirements
- **CPU**: 8+ cores
- **RAM**: 16GB or more
- **Storage**: 20GB SSD
- **Network**: High-speed internet connection

> **IMPORTANT**: The Nexus zkVM process is memory-intensive. If you have less than 12GB RAM, you may encounter "Out of Memory" errors. Adding swap space can help but will impact performance.

## Installation

### Prerequisites (Install These First)

Before installing the Nexus client, you must install these dependencies:

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install essential build tools
sudo apt install -y build-essential pkg-config libssl-dev git-all curl nano cmake

# Install Rust (required)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# Install protocol buffers
sudo apt install -y protobuf-compiler

# Add required Rust target
rustup target add riscv32i-unknown-none-elf
```

### Nexus Client Installation

After installing the prerequisites, install the Nexus client:

#### One-Command Install
```bash
curl https://cli.nexus.xyz/ | sh
```

#### Manual Installation
If the quick install fails, you can download from source:

```bash
# Clone the repository
git clone https://github.com/nexus-xyz/nexus-client
cd nexus-client

# Build and install
cargo build --release
sudo cp target/release/nexus-client /usr/local/bin/
```

## Start Your Node

1. Create an account at [app.nexus.xyz](https://app.nexus.xyz)
2. Run the client:
   ```bash
   curl https://cli.nexus.xyz/ | sh
   ```
3. Accept the Terms of Use
4. Link your account when prompted (required for earning rewards)

## Earn NEX Points

- NEX Points are earned by contributing compute power
- Points are updated approximately every 15 minutes
- You must link your account to receive points
- View your earnings in the "Earnings" section of your account

## Network Information

| Property | Value |
|----------|-------|
| Chain ID | 393 |
| Native Token | Nexus Token (NEX) |
| RPC URL | `https://rpc.nexus.xyz/http` |
| WebSocket | `wss://rpc.nexus.xyz/ws` |

## Common Issues

### Out of Memory Errors

If you see `Out of memory: Killed process` errors:

```bash
# Add swap space (16GB)
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make swap permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Other Common Problems

1. Ensure your internet connection is stable
2. Check if your system meets the minimum requirements
3. Restart the client with: `curl https://cli.nexus.xyz/ | sh`
4. Join the Discord server for support

## Using tmux for Background Operation

To keep your node running in the background:

```bash
# Install tmux
sudo apt install tmux

# Create a new tmux session
tmux new-session -d -s nexus

# Run the client in the session
tmux send-keys -t nexus "curl https://cli.nexus.xyz/ | sh" C-m

# To reconnect to the session later
tmux attach -t nexus

# To detach from session (keep it running)
# Press Ctrl+B then D
```

To automatically start the node when your system boots:

```bash
# Create a startup script
echo '#!/bin/bash
tmux new-session -d -s nexus
tmux send-keys -t nexus "curl https://cli.nexus.xyz/ | sh" C-m' > ~/start-nexus.sh

# Make it executable
chmod +x ~/start-nexus.sh

# Add to crontab
(crontab -l 2>/dev/null; echo "@reboot ~/start-nexus.sh") | crontab -
```

## Why Run a Nexus Node?

- Contribute to a global supercomputer network
- Earn NEX Points for your contributions
- Be part of building a verifiable Internet
- Support the Nexus Layer-1 blockchain ecosystem
