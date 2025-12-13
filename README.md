<div align="center">

# Nexus Network

<h3>Complete installation guide for running a Nexus node on Testnet III.</h3>

<p>
  <img src="https://img.shields.io/badge/Status-Testnet%20III%20LIVE-green?style=for-the-badge" alt="Status" />
  <img src="https://img.shields.io/badge/Earn-NEX%20Points-blue?style=for-the-badge" alt="Earn" />
</p>

<p>
  <img src="https://img.shields.io/badge/Platform-Ubuntu-E95420" alt="Ubuntu" />
  <img src="https://img.shields.io/badge/Type-Guide-blue" alt="Guide" />
</p>

</div>

---

## What is Nexus Network?

Your computer helps process blockchain calculations and you get paid in **NEX Points** for it.

Nexus Network is a giant worldwide computer made of thousands of normal computers. When you join, your computer does small math problems to help verify blockchain transactions. You earn NEX Testnet Points that turn into NEX Testnet Tokens.

---

## Who is This For?

| User Type | Use Case |
|-----------|----------|
| **Node Operators** | Earn rewards by sharing compute power |
| **Crypto Enthusiasts** | Support cutting-edge zkVM technology |
| **Server Owners** | Monetize idle hardware |
| **Early Adopters** | Get positioned before Mainnet |

---

## System Requirements

| Component | Minimum | Best Performance |
|-----------|---------|------------------|
| **CPU** | 4 cores | 8+ cores |
| **RAM** | 8 GB | 16 GB+ |
| **Storage** | 10 GB free | SSD preferred |
| **Internet** | Stable connection | Fast & stable |

> ⚠️ **Low on RAM?** If you have less than 12GB, we'll add swap space to prevent crashes.

---

## Quick Start

### 1. Create Your Account

1. Go to [app.nexus.xyz](https://app.nexus.xyz)
2. Click **"Connect"**
3. Sign up with Email or Crypto Wallet
4. Done!

### 2. Install Nexus (One Command)

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl nano screen git
curl https://cli.nexus.xyz/ | sh
source ~/.bashrc
```

### 3. Link Your Node

```bash
nexus-network
```
- Accept Terms of Use: **yes**
- Link to account: **yes**
- Log in with your account

### 4. Run 24/7 with Screen

```bash
screen -S nexus
nexus-network start
```
Press `Ctrl+A` then `D` to detach.

---

# Technical Documentation

<details>
<summary><b>📥 Step-by-Step Installation</b></summary>

### STEP 1: Update Your Computer

```bash
sudo apt update && sudo apt upgrade -y
```
**Time:** 2-5 minutes

### STEP 2: Install Basic Tools

```bash
sudo apt install -y curl nano screen git
```

What you're installing:
- `curl` = Downloads files
- `nano` = Simple text editor
- `screen` = Keeps programs running in background
- `git` = Tool for downloading code

### STEP 3: Install Nexus

```bash
curl https://cli.nexus.xyz/ | sh
```

During installation:
- Press **Enter** when asked questions (accepts defaults)
- Wait 3-5 minutes

### STEP 4: Activate Nexus

```bash
source ~/.bashrc
```

### STEP 5: Test If It Worked

```bash
nexus-network --help
```

If you see a help menu = SUCCESS!

</details>

<details>
<summary><b>🔗 Linking Your Node</b></summary>

### Link to Your Account

```bash
nexus-network
```

**Question 1: Accept Terms of Use?**
- Type: **yes**
- Press: **Enter**

**Question 2: Link to your account?**
- Type: **yes**
- Press: **Enter**
- Only linked nodes earn points!

**Question 3: Login**
- Follow instructions to log in
- Use the same email/wallet from app.nexus.xyz

### Test Your Node

```bash
nexus-network start
```

Let it run for 2-3 minutes. If you see activity = it's working!

**To stop:** Press `Ctrl+C`

</details>

<details>
<summary><b>🔄 Running 24/7 with Screen</b></summary>

### Create Screen Session

```bash
screen -S nexus
```

### Start Your Node

```bash
nexus-network start
```

### Leave It Running

1. Press **`Ctrl+A`** (hold both keys)
2. Release both keys
3. Press **`D`** (just the D key)

You should see: "detached from screen"

**Your node is now running in the background!**

### Manage Your Node

| Command | Description |
|---------|-------------|
| `screen -ls` | Check if node is running |
| `screen -r nexus` | View your running node |
| `screen -X -S nexus quit` | Stop your node |

</details>

<details>
<summary><b>🔁 Auto-Start on Reboot</b></summary>

### Create the Script

```bash
nano ~/start-nexus.sh
```

Paste this:
```bash
#!/bin/bash
sleep 60
screen -X -S nexus quit 2>/dev/null
screen -dmS nexus nexus-network start
echo "$(date): Started nexus node" >> ~/nexus-startup.log
```

Save: `Ctrl+X`, `Y`, `Enter`

### Make Script Runnable

```bash
chmod +x ~/start-nexus.sh
```

### Set to Run on Boot

```bash
crontab -e
```

Add this line at the bottom:
```bash
@reboot /home/YOUR_USERNAME/start-nexus.sh
```

Replace `YOUR_USERNAME` with your actual username (check with `whoami`).

### Test

```bash
sudo reboot
# After restart, wait 60 seconds
screen -ls
```

If you see "nexus" = Auto-start works!

</details>

<details>
<summary><b>🛟 Fix Low Memory Problems</b></summary>

### Create Swap File (16GB)

```bash
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Verify

```bash
free -h
```

Look for "Swap:" line - should show 16GB.

</details>

<details>
<summary><b>⚡ Advanced Commands</b></summary>

### Manual Node Management

**Register your wallet:**
```bash
nexus-network register-user --wallet-address YOUR_WALLET_ADDRESS
```

**Register a new node:**
```bash
nexus-network register-node
```

**Start with specific node ID:**
```bash
nexus-network start --node-id YOUR_NODE_ID
```

**Logout/unlink:**
```bash
nexus-network logout
```

### View Configuration

```bash
cat ~/.nexus/config.json
```

### Performance Monitoring

```bash
htop           # System monitor (Q to exit)
free -h        # RAM usage
df -h          # Disk space
speedtest-cli  # Internet speed
```

### Find Your IP

```bash
hostname -I      # Local IP
curl ifconfig.me # Public IP
```

</details>

<details>
<summary><b>🔧 Troubleshooting</b></summary>

### "Command Not Found"
```bash
source ~/.bashrc
nexus-network --help
```

Still not working? Reinstall:
```bash
curl https://cli.nexus.xyz/ | sh
source ~/.bashrc
```

### "Node Won't Connect"
```bash
ping -c 4 google.com  # Check internet
screen -X -S nexus quit
screen -S nexus
nexus-network start
```

### "Node Not in Dashboard"
1. Stop node: `screen -X -S nexus quit`
2. Run: `nexus-network`
3. Link to account
4. Start node again
5. Wait 5 minutes, refresh dashboard

### "Out of Memory"
Follow the swap file instructions above.

### "Low Points / Slow Earning"
- Check if node keeps disconnecting
- Use screen and auto-start for 24/7 uptime
- Ensure node is linked to your account

</details>

---

## Quick Commands

### Node Commands

| Action | Command |
|--------|---------|
| Start node (test) | `nexus-network start` |
| See all options | `nexus-network --help` |
| Stop node | `Ctrl+C` |
| Link to account | `nexus-network` |
| Logout/unlink | `nexus-network logout` |

### Screen Commands

| Action | Command |
|--------|---------|
| Create session | `screen -S nexus` |
| List sessions | `screen -ls` |
| View node | `screen -r nexus` |
| Leave running | `Ctrl+A` then `D` |
| Stop node | `screen -X -S nexus quit` |

### System Commands

| Action | Command |
|--------|---------|
| Check RAM | `free -h` |
| Monitor resources | `htop` |
| Check disk space | `df -h` |
| Your username | `whoami` |
| Your IP | `hostname -I` |

---

## How You Earn

### NEX Testnet Points
- Automatically earned while node is running
- Check at [app.nexus.xyz](https://app.nexus.xyz)

### Earn More Points
- **Run 24/7** - More uptime = more points
- **Keep it linked** - Anonymous nodes earn nothing
- **Good hardware** - Faster CPU = more computations
- **Stable internet** - Less disconnections
- **Multiple devices** - Up to 100 nodes per account

---

## Important Links

| Resource | Link |
|----------|------|
| Dashboard | [app.nexus.xyz](https://app.nexus.xyz) |
| Node Management | [app.nexus.xyz/nodes](https://app.nexus.xyz/nodes) |
| Documentation | [docs.nexus.xyz](https://docs.nexus.xyz) |
| Discord | [discord.gg/nexus-xyz](https://discord.gg/nexus-xyz) |

---

## Security Warning

### 🚨 SCAM ALERT

**Nexus support will NEVER:**
- ❌ Send you a private message first
- ❌ Ask for your password or private keys
- ❌ Ask you to send money or crypto

**Real support is ONLY in:**
- ✅ Discord public channels
- ✅ GitHub issues
- ✅ Official docs

**If someone messages you claiming to be support = IT IS A SCAM!**

---

## Contributing

Contributions welcome! Feel free to submit issues or pull requests.

---

## Disclaimer

> This is a **Testnet** - real tokenomics come with Mainnet. Point rates may change. Keep earning to be ready for Mainnet rewards!

---

<div align="center">

Built by [@bokiko](https://github.com/bokiko)

*Join the verifiable computing revolution*

</div>
