# Nexus Network Node Setup Guide

> **STATUS:** Testnet II is over. Devnet mode is live.

## What is Nexus Network?

The Nexus Network is a distributed supercomputer where you contribute your computer's power to help process blockchain transactions. In return, you earn NEX Points as rewards.

**Think of it like:** Your computer becomes part of a giant network that helps run a new type of internet.

---

## Before You Start

### Check Your Computer Specs

**Minimum Requirements (Will work but slow):**
- 4-core CPU
- 8GB RAM 
- 10GB free storage
- Stable internet

**Recommended (Better performance):**
- 8+ core CPU
- 16GB+ RAM
- 20GB+ SSD storage
- Fast internet

> ⚠️ **IMPORTANT:** If you have less than 12GB RAM, you might get "Out of Memory" errors. We'll show you how to fix this later.

---

## Step 1: Prepare Your System

### Update Everything First
```bash
sudo apt update
```

```bash
sudo apt upgrade -y
```

### Install Basic Tools
```bash
sudo apt install -y build-essential
```

### Install All Required Software
```bash
sudo apt install -y pkg-config libssl-dev git-all curl nano cmake tmux cron protobuf-compiler
```

---

## Step 2: Install Rust Programming Language

Rust is required to build the Nexus client.

### Download and Install Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```

### Activate Rust for Current Session
```bash
source "$HOME/.cargo/env"
```

### Add Special Rust Component
```bash
rustup target add riscv32i-unknown-none-elf
```

---

## Step 3: Install Nexus Client

### Quick Install Method
```bash
curl https://cli.nexus.xyz/ | sh
```

### Copy Client to System Location
After the install completes, find and copy the client:
```bash
sudo cp ~/.nexus/network-api/clients/cli/target/release/nexus-network /usr/local/bin/nexus-client
```

### Test Installation
```bash
nexus-client --help
```
You should see help text if it worked.

---

## Step 4: Create Account and Start Node

### 1. Create Your Account
- Go to [app.nexus.xyz](https://app.nexus.xyz) in your web browser
- Sign up with your email
- **Important:** Remember your email - you'll need it to link your node

### 2. Start Your Node
```bash
nexus-client start
```

### 3. Follow the Prompts
- Accept the Terms of Use
- Link your account using your email
- Your node will start earning NEX Points automatically

---

## Step 5: Run Node in Background (Optional but Recommended)

This keeps your node running even when you close the terminal.

### Start Background Session
```bash
tmux new-session -d -s nexus
```

### Run Nexus in Background
```bash
tmux send-keys -t nexus "nexus-client start" C-m
```

### Check Your Node Anytime
```bash
tmux attach -t nexus
```

**To leave without stopping the node:** Press `Ctrl+B` then press `D`

---

## Step 6: Auto-Start When Computer Boots (Optional)

### Enable Auto-Start Service
```bash
sudo systemctl enable cron
```

```bash
sudo systemctl start cron
```

### Create Startup Script
```bash
nano ~/start-nexus.sh
```

### Add This Content to the File
```bash
#!/bin/bash
sleep 30
tmux kill-session -t nexus 2>/dev/null
tmux new-session -d -s nexus
tmux send-keys -t nexus "nexus-client start" C-m
echo "$(date): Nexus started automatically" >> ~/nexus-startup.log
```

### Save the File
Press `Ctrl+X`, then `Y`, then `Enter`

### Make Script Runnable
```bash
chmod +x ~/start-nexus.sh
```

### Test Your Script
```bash
~/start-nexus.sh
```

### Check if it Worked
```bash
tmux list-sessions
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

## Fix Memory Problems (If You Get "Out of Memory" Errors)

### Create Swap Space (16GB)
```bash
sudo fallocate -l 16G /swapfile
```

### Set Permissions
```bash
sudo chmod 600 /swapfile
```

### Make it a Swap File
```bash
sudo mkswap /swapfile
```

### Turn On Swap
```bash
sudo swapon /swapfile
```

### Make Swap Permanent
```bash
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Check if Swap is Working
```bash
free -h
```

---

## Understanding NEX Points

- **What they are:** Rewards for contributing your computer power
- **How often updated:** Every 15 minutes
- **Requirement:** Must link your account to earn points
- **Where to check:** Login at app.nexus.xyz and click "Earnings"

---

## Network Technical Info

| Setting | Value |
|---------|-------|
| Chain ID | 393 |
| Token | NEX |
| RPC URL | `https://rpc.nexus.xyz/http` |
| WebSocket | `wss://rpc.nexus.xyz/ws` |

---

## Common Problems and Solutions

### Node Won't Start
1. Check internet connection
2. Try restarting: `nexus-client start`
3. Check if you have enough free space: `df -h`

### Out of Memory Errors
- Follow the "Fix Memory Problems" section above
- Consider upgrading your RAM if possible

### Can't Find nexus-client Command
```bash
sudo cp ~/.nexus/network-api/clients/cli/target/release/nexus-network /usr/local/bin/nexus-client
```

### Node Stops Working
```bash
tmux kill-session -t nexus
tmux new-session -d -s nexus
tmux send-keys -t nexus "nexus-client start" C-m
```

---

## Quick Commands Reference

**Start node:** `nexus-client start`  
**Check running nodes:** `tmux list-sessions`  
**Connect to running node:** `tmux attach -t nexus`  
**Leave node running:** Press `Ctrl+B` then `D`  
**Restart node:** Kill session, then start new one  
**Check system resources:** `htop` or `free -h`

---

## Why Run a Nexus Node?

- 🏆 **Earn rewards** in NEX Points
- 🌐 **Help build** the future of internet infrastructure  
- 💻 **Use your computer** to contribute to something bigger
- 🚀 **Be early** in a new blockchain ecosystem
- 📈 **Potential future value** of earned NEX Points

---

## Need Help?

- Join the official Discord server
- Check the Nexus GitHub for updates
- Visit app.nexus.xyz for account issues
- Make sure you followed each step exactly as written

**Remember:** Your node needs to stay running to earn points. The tmux background method is highly recommended!
