# Nexus Network: Quick Setup Guide

## 1. About the Network

The Nexus Network is a distributed supercomputer that concentrates computing power into a single blockchain. It aims to condense the entire Internet into a single proof through the Nexus zkVM.

When you connect to the network, your device becomes a node, contributing compute power to verify computations on the Internet.

- **Chain ID**: 393
- **Native Token**: Nexus Token (NEX)
- **RPC (HTTP)**: `https://rpc.nexus.xyz/http`
- **RPC (WebSocket)**: `wss://rpc.nexus.xyz/ws`

## 2. Hardware Requirements

To run a Nexus node effectively, your system should meet these minimum requirements:

- **CPU**: 4+ cores recommended
- **RAM**: 8GB+ recommended
- **Storage**: 10GB of free space
- **Network**: Stable internet connection (10+ Mbps)
- **OS**: Ubuntu 20.04+ (Linux recommended)

For virtual machines:
- Ensure dedicated CPU cores
- Allocate at least 8GB RAM
- Use direct network access when possible

## 3. Account Management

### Account Options

1. **Link to Nexus Account (Recommended)**
   - Create an account at [app.nexus.xyz](https://app.nexus.xyz)
   - Your contributions will earn NEX Points
   - Track your progress on the leaderboard

2. **Anonymous Proving**
   - No account required
   - No NEX Points earned

### Changing Your Settings

If you need to change your account linking:

```bash
rm -rf ~/.nexus
```

Then run the CLI again to restart the setup process.

## 4. Installation and Setup

### Step 1: Install tmux (Required)

```bash
sudo apt update
```

```bash
sudo apt install -y tmux
```

### Step 2: Install the Nexus CLI

```bash
curl https://cli.nexus.xyz/ | sh
```

This single command will handle the installation process including all dependencies.

## 5. Running Your Node

### Step 1: Start a tmux Session (Required)

```bash
tmux new -s nexus
```

### Step 2: Run the Installation Command in tmux

```bash
curl https://cli.nexus.xyz/ | sh
```

This command will install AND run the Nexus node in one step.

On first run, you'll be asked to:
1. Accept the Terms of Use
2. Choose between anonymous or linked proving

### Step 3: Detach from tmux

To keep the node running after disconnecting, detach from the tmux session:
- Press `Ctrl+B`, then press `D`

### Step 5: Set Up Automatic Startup (Optional)

To make your node start automatically when your system reboots:

Create a startup script:

```bash
nano ~/start_nexus.sh
```

Add this content to the file:

```bash
#!/bin/bash
# Check if tmux session exists, if not create it and start Nexus
if ! tmux has-session -t nexus 2>/dev/null; then
    tmux new-session -d -s nexus
    tmux send-keys -t nexus "curl https://cli.nexus.xyz/ | sh" C-m
fi
```

Save the file (Ctrl+O, then Enter, then Ctrl+X)

Make the script executable:

```bash
chmod +x ~/start_nexus.sh
```

Add to crontab to run at startup:

```bash
(crontab -l 2>/dev/null; echo "@reboot ~/start_nexus.sh") | crontab -
```

Now your Nexus node will automatically start in a tmux session whenever your system reboots.

## 6. Troubleshooting

### Installation Issues

If the installation doesn't work properly:

```bash
tmux kill-session -t nexus
```

Then start over with a new tmux session.

### Node Not Working

Verify your node is running by reconnecting to the tmux session:

```bash
tmux attach -t nexus
```

Check if it's properly linked to your account on [app.nexus.xyz](https://app.nexus.xyz)

### tmux Session Management

List all tmux sessions:

```bash
tmux ls
```

Kill a stuck session:

```bash
tmux kill-session -t nexus
```

---

**Note**: This guide was created by [Bokiko](https://github.com/bokiko) for the Cloudiko.io community.
