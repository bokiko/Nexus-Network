Here's the complete README.md file in a single, separate file:

# Nexus Network Onboarding Script

An automated script to simplify the process of setting up and running a Nexus Network node.

## Features

- Automatic installation of prerequisites (Rust, CMake, Protocol Buffers)
- Quick setup with guided instructions
- Tmux integration for persistent sessions
- Automatic node restart on system reboot
- Network configuration guidance
- Support for both quick and manual installation options

## Usage

Run the script using:

```bash
curl -s https://raw.githubusercontent.com/bokiko/nexus-network/main/nexus-onboarding.sh | bash
```

Or download and run manually:

```bash
chmod +x nexus-onboarding.sh
./nexus-onboarding.sh
```

## What Does This Script Do?

1. **Checks and Installs Prerequisites**
   - Verifies if curl, tmux, and nano are installed
   - Installs Rust, CMake, and Protocol Buffers if needed
   - Adds the required RISC-V target for Rust

2. **Offers Installation Options**
   - Quick Install: Uses the official Nexus installer
   - Manual Installation: Guides through the manual setup process

3. **Configures Your Environment**
   - Sets up tmux for persistent sessions
   - Creates an auto-start script for system reboots
   - Displays your node's public IP address

4. **Provides Network Information**
   - Chain ID: 393
   - Native Token: Nexus Token (NEX)
   - RPC (HTTP): https://rpc.nexus.xyz/http
   - RPC (WebSocket): wss://rpc.nexus.xyz/ws

## About Nexus Network

The Nexus Network is a distributed supercomputer that concentrates the world's computing power into a single blockchain: the Nexus Layer-1. It is powered by the Nexus zkVM with a goal to condense the entire Internet into a single proof.

When you connect to the network via the Nexus App or CLI, your device becomes a node, contributing compute to the network, which helps verify computations on the Internet.

By participating in the Nexus Network and linking your account, you can earn NEX Points for your contributions.

## Requirements

- A Linux-based system (Ubuntu/Debian recommended)
- Internet connection
- Basic terminal knowledge

## Support

If you encounter any issues or have questions, please:
- Open an issue in this repository
- Join the Nexus Discord community
- Refer to the official documentation at https://docs.nexus.xyz

## About This Script

Created by [Bokiko](https://github.com/bokiko) for the Cloudiko.io community.

## License

MIT
