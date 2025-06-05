# Nexus Network Node Setup Guide

> **STATUS:** Devnet is live! Join the network and start earning NEX Points.

## What is Nexus Network?

The Nexus Network is a distributed supercomputer where you contribute your computer's power to help process blockchain transactions. In return, you earn NEX Points as rewards.

**Think of it like:** Your computer becomes part of a giant network that helps run a new type of internet.

---

## Before You Start

### Check Your Computer Specs

**Minimum Requirements:**
- 4-core CPU
- 8GB RAM 
- 10GB free storage
- Stable internet connection

**Recommended:**
- 8+ core CPU
- 16GB+ RAM
- 20GB+ SSD storage
- Fast internet connection

> ⚠️ **IMPORTANT:** If you have less than 12GB RAM, you might get "Out of Memory" errors. We'll show you how to fix this later.

---

## Step 1: Prepare Your System

### Update Everything First
```bash
sudo apt update && sudo apt upgrade -y
```

### Install Required Packages
```bash
sudo apt install -y build-essential pkg-config libssl-dev git-all curl nano cmake tmux cron protobuf-compiler
```

---

## Step 2: Install Rust Programming Language

### Download and Install Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```

### Activate Rust
```bash
source "$HOME/.cargo/env"
```

### Add Required Target
```bash
rustup target add riscv32i-unknown-none-elf
```

---

## Step 3: Install Nexus CLI

### Try Quick Install First
```bash
curl https://cli.nexus.xyz/ | sh
```

### Reload Environment
```bash
source ~/.bashrc
```

### Test Installation
```bash
nexus-network --help
```

### If You Get GLIBC Error, Build From Source

**Step 1:** Clone the repository
```bash
git clone https://github.com/nexus-xyz/nexus-cli
```

**Step 2:** Go to the CLI directory
```bash
cd nexus-cli/clients/cli
```

**Step 3:** Build from source
```bash
cargo build --release
```

**Step 4:** Copy to your PATH
```bash
sudo cp target/release/nexus-network ~/.nexus/bin/
```

**Step 5:** Test again
```bash
nexus-network --help
```

---

## Step 4: Configure Your Node ID

### Create Config Directory
```bash
mkdir -p ~/.nexus
```

### Create Config File
```bash
nano ~/.nexus/config.json
```

### Add Your Node ID
```json
{
   "node_id": "YOUR_NODE_ID_HERE"
}
```

Replace `YOUR_NODE_ID_HERE` with your actual node ID from [app.nexus.xyz](https://app.nexus.xyz)

### Save the File
Press `Ctrl+X`, then `Y`, then `Enter`

---

## Step 5: Start Your Node

### Basic Start (Will stop when terminal closes)
```bash
nexus-network start --env beta
```

### Start in Background with tmux (Recommended)

**Step 1:** Create tmux session
```bash
tmux new-session -d -s nexus
```

**Step 2:** Start node in tmux
```bash
tmux send-keys -t nexus "nexus-network start --env beta" C-m
```

**Step 3:** Check your node
```bash
tmux attach -t nexus
```

**Step 4:** Leave node running (don't close it)
Press `Ctrl+B` then press `D`

---

## Step 6: Auto-Start on Boot (Optional)

### Enable Cron Service
```bash
sudo systemctl enable cron && sudo systemctl start cron
```

### Create Startup Script
```bash
nano ~/start-nexus.sh
```

### Add Script Content
```bash
#!/bin/bash
# Wait for system to fully boot
sleep 30

# Kill any existing nexus sessions
tmux kill-session -t nexus 2>/dev/null

# Create new tmux session and start nexus node
tmux new-session -d -s nexus
tmux send-keys -t nexus "nexus-network start --env beta" C-m

# Log startup
echo "$(date): Nexus node started automatically" >> ~/nexus-startup.log
```

### Make Script Executable
```bash
chmod +x ~/start-nexus.sh
```

### Test Your Script
```bash
~/start-nexus.sh
```

### Add to Auto-Start
```bash
crontab -e
```

Add this line at the bottom:
```bash
@reboot /home/$(whoami)/start-nexus.sh
```

Save with `Ctrl+X`, then `Y`, then `Enter`

---

## Step 7: Fix Memory Problems (If Needed)

If you get "Out of Memory" errors, create swap space:

### Create 16GB Swap File
```bash
sudo fallocate -l 16G /swapfile
```

### Set Permissions
```bash
sudo chmod 600 /swapfile
```

### Initialize Swap
```bash
sudo mkswap /swapfile
```

### Enable Swap
```bash
sudo swapon /swapfile
```

### Make Swap Permanent
```bash
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Verify Swap is Active
```bash
free -h
```

---

## Node Management

### Check if Node is Running
```bash
ps aux | grep nexus-network
```

### Check tmux Sessions
```bash
tmux list-sessions
```

### Connect to Running Node
```bash
tmux attach -t nexus
```

### Leave Node Running
Press `Ctrl+B` then press `D`

### Stop Node
```bash
tmux kill-session -t nexus
```

### Restart Node
```bash
tmux kill-session -t nexus
tmux new-session -d -s nexus
tmux send-keys -t nexus "nexus-network start --env beta" C-m
```

---

## Understanding NEX Points

- **What they are:** Rewards for contributing computational power
- **How earned:** Your node processes zkVM computations
- **Update frequency:** Points update periodically
- **Requirement:** Must have valid node ID and keep node running
- **Where to check:** Login at [app.nexus.xyz](https://app.nexus.xyz)

---

## Network Information

| Setting | Value |
|---------|-------|
| Network | Devnet |
| Chain ID | 393 |
| Token | NEX |
| RPC URL | `https://rpc.nexus.xyz/http` |
| WebSocket | `wss://rpc.nexus.xyz/ws` |

---

## Troubleshooting

### Node Won't Start
1. Check internet connection: `ping google.com`
2. Verify node ID in config: `cat ~/.nexus/config.json`
3. Check system resources: `free -h`
4. Try restarting: Kill session and start new one

### GLIBC Version Error
- Build from source using the instructions in Step 3
- This happens when your system is older than the precompiled binary

### Out of Memory Errors
- Follow Step 7 to add swap space
- Consider upgrading RAM if possible
- Close unnecessary programs

### Node Not Connecting
- Wait 5-10 minutes for initial connection
- Check internet stability
- Restart the node
- Verify node ID is correct

### Auto-Start Not Working
- Check script exists: `ls -la ~/start-nexus.sh`
- Check crontab: `crontab -l`
- Check startup log: `cat ~/nexus-startup.log`
- Test script manually: `~/start-nexus.sh`

### Can't Find Node Process
```bash
# Find all nexus processes
pgrep -f nexus

# Check what's using your ports
netstat -tulpn | grep nexus
```

---

## Quick Commands Reference

**Start node:** `nexus-network start --env beta`  
**Check if running:** `ps aux | grep nexus-network`  
**Create tmux session:** `tmux new-session -d -s nexus`  
**Check sessions:** `tmux list-sessions`  
**Connect to session:** `tmux attach -t nexus`  
**Leave session running:** Press `Ctrl+B` then `D`  
**Stop node:** `tmux kill-session -t nexus`  
**Check system resources:** `htop` or `free -h`

---

## Important Notes

### Terminal vs Background
- **Terminal start:** Node stops when you close terminal
- **tmux start:** Node keeps running even when you close terminal
- **Always use tmux** for production setups

### Node ID Requirements
- Required for earning NEX Points
- Get from [app.nexus.xyz](https://app.nexus.xyz)
- Store in `~/.nexus/config.json`
- Without it, node won't contribute properly

### System Resources
- Node is CPU and memory intensive
- Monitor with `htop` command
- Add swap if you have limited RAM
- Ensure stable internet connection

---

## Why Run a Nexus Node?

- 🏆 **Earn NEX Points** for contributing compute power
- 🌐 **Support** the Nexus Network infrastructure  
- 💻 **Utilize** your computer's idle processing power
- 🚀 **Be part** of cutting-edge zkVM technology
- 📈 **Early access** to the Nexus ecosystem
- 🔒 **Help build** the verifiable internet

---

## Getting Your Node ID

### Method 1: Nexus App
1. Go to [app.nexus.xyz](https://app.nexus.xyz)
2. Create account or login
3. Find your node ID in the dashboard
4. Copy it to your config file

### Method 2: Let Node Generate One
1. Start node without config file
2. It will prompt you to create/enter node ID
3. Follow the prompts
4. Save the generated ID for future use

---

## Need Help?

- **Official Docs:** [docs.nexus.xyz](https://docs.nexus.xyz)
- **Discord Community:** Join the official Nexus Discord
- **Account Issues:** Visit [app.nexus.xyz](https://app.nexus.xyz)
- **Technical Issues:** Check GitHub repositories
- **Network FAQ:** [Network FAQ](https://docs.nexus.xyz/layer-1/network-devnet/faq)

---

## Final Checklist

Before you finish, make sure:

- ✅ Node is running in tmux session
- ✅ Node ID is configured correctly
- ✅ Auto-start script is set up (optional)
- ✅ You can connect to your node with `tmux attach -t nexus`
- ✅ Node shows as connected to the network
- ✅ You can check your NEX Points at app.nexus.xyz

**Remember:** Keep your node running 24/7 to maximize NEX Point earnings!
