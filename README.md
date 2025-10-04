# 🚀 Nexus Network - Simple Installation Guide for Testnet III

**STATUS: Testnet III is LIVE!** Join now and earn NEX Testnet Points and Tokens.

---

## 📖 What is Nexus Network?

**Simple explanation:** Your computer helps process blockchain calculations and you get paid in NEX Points for it.

**More details:** Nexus Network is like a giant worldwide computer made of thousands of normal computers (including yours!). When you join, your computer does small math problems to help verify blockchain transactions. You earn NEX Testnet Points that turn into NEX Testnet Tokens.

---

## 💻 What You Need

### Your Computer Should Have:
- **Processor:** 4 cores or more (most modern computers have this)
- **Memory (RAM):** 8GB minimum, 12GB+ is better
- **Hard Drive Space:** 10GB free
- **Internet:** Must stay connected

### Best Performance:
- **Processor:** 8+ cores
- **Memory (RAM):** 16GB or more
- **Hard Drive:** SSD (faster than regular hard drive)
- **Internet:** Fast and stable

⚠️ **Low on RAM?** If you have less than 12GB RAM, your node might crash. Don't worry - we'll fix this by creating "swap space" (uses hard drive as extra memory).

---

## 🎯 First: Create Your Account

**Before installing anything, you need an account!**

1. Go to **[app.nexus.xyz](https://app.nexus.xyz)**
2. Click **"Connect"**
3. Choose one:
   - Sign up with **Email** (easiest)
   - Sign up with **Crypto Wallet** (like MetaMask)
4. Done!

**Why?** This account tracks your points and manages all your nodes. Keep your login safe!

---

## 📦 STEP 1: Update Your Computer

**Copy this command and press Enter:**
```bash
sudo apt update && sudo apt upgrade -y
```

**What happens:** Your Ubuntu computer checks for updates and installs them.

**Time:** 2-5 minutes

---

## 🛠️ STEP 2: Install Basic Tools

**Copy this command and press Enter:**
```bash
sudo apt install -y curl nano screen git
```

**What you're installing:**
- `curl` = Downloads files
- `nano` = Simple text editor
- `screen` = Keeps programs running in background
- `git` = Tool for downloading code

**Time:** 1-2 minutes

---

## 🎉 STEP 3: Install Nexus (One Command!)

**This is the main installation. Copy this command:**
```bash
curl https://cli.nexus.xyz/ | sh
```

**What happens:**
- Downloads Nexus software
- Installs everything automatically
- Sets up your computer to run a node

**During installation:**
- Just press **Enter** when asked questions (accepts defaults)
- Wait for it to finish (takes 3-5 minutes)

**Time:** 3-5 minutes

---

## ⚙️ STEP 4: Activate Nexus

**Copy this command:**
```bash
source ~/.bashrc
```

**What this does:** Makes Nexus commands available in your terminal right now.

---

## ✅ STEP 5: Test If It Worked

**Copy this command:**
```bash
nexus-network --help
```

**If you see a help menu = SUCCESS! ✅**

**If you get "command not found":**
1. Close your terminal completely
2. Open a new terminal
3. Try the command again

---

## 🔧 STEP 6: Link Your Node to Your Account

**This is important! Run this command:**
```bash
nexus-network
```

**You'll see questions. Here's what to do:**

### Question 1: Accept Terms of Use?
- Type: **yes**
- Press: **Enter**

### Question 2: Link to your account?
- Type: **yes** 
- Press: **Enter**
- **Why?** Only linked nodes earn points!

### Question 3: Login
- Follow the instructions to log in with your account
- Use the same email/wallet you created earlier

**After linking:** Your node is connected to your dashboard at app.nexus.xyz!

---

## 🚀 STEP 7: Test Your Node (Quick Test)

**Let's see if everything works:**
```bash
nexus-network start
```

**What you should see:**
- "Connecting to network..."
- "Processing computations..."
- Numbers and activity

**Let it run for 2-3 minutes. If you see activity = it's working! ✅**

**To stop the test:** Press `Ctrl+C`

---

## 📊 STEP 8: Check Your Dashboard

**Make sure your node is registered:**

1. Go to **[app.nexus.xyz/nodes](https://app.nexus.xyz/nodes)**
2. Log in
3. You should see your node listed
4. It should show "Active" or "Online"

**If you don't see your node:** Try waiting 5 minutes and refresh the page.

---

## 🔄 STEP 9: Run Node 24/7 with Screen

**Why use Screen?** Right now, if you close your terminal, your node stops. Screen keeps it running forever!

### Create Screen Session

**Copy this command:**
```bash
screen -S nexus
```

**What happened?** You're now inside a "screen session" - a special terminal that stays running.

### Start Your Node

**Copy this command:**
```bash
nexus-network start
```

**Your node is now running!**

### Leave It Running (Important!)

To leave your node running and get your normal terminal back:

1. Press **`Ctrl+A`** (hold both keys)
2. Release both keys
3. Press **`D`** (just the D key)

**You should see:** "detached from screen"

**Your node is now running in the background! ✅**

---

## 🔍 STEP 10: Manage Your Node

### Check If Node is Running
```bash
screen -ls
```
**You should see:** "nexus" in the list = node is running ✅

### View Your Running Node
```bash
screen -r nexus
```
**Now you can see what your node is doing!**

**To leave again:** Press `Ctrl+A` then press `D`

### Stop Your Node Completely
```bash
screen -X -S nexus quit
```
**This kills the node.** Only do this if you want to stop earning!

### Restart Your Node
```bash
screen -X -S nexus quit
screen -S nexus
nexus-network start
```
**Then press:** `Ctrl+A` then `D` to detach.

---

## 🔁 STEP 11: Auto-Start After Reboot (Optional)

**Want your node to start automatically when your computer reboots?** Follow these steps!

### Part A: Create the Auto-Start Script

**1. Open nano editor:**
```bash
nano ~/start-nexus.sh
```

**2. Copy this ENTIRE script and paste it:**

```bash
#!/bin/bash
# Wait for system to boot up
sleep 60

# Stop any old sessions
screen -X -S nexus quit 2>/dev/null

# Start new node in screen
screen -dmS nexus nexus-network start

# Write log
echo "$(date): Started nexus node" >> ~/nexus-startup.log
```

**3. Save the file:**
- Press `Ctrl+X`
- Press `Y`
- Press `Enter`

### Part B: Make Script Runnable

**Copy this command:**
```bash
chmod +x ~/start-nexus.sh
```

### Part C: Test the Script

**Copy this command:**
```bash
~/start-nexus.sh
```

**Wait 60 seconds, then check:**
```bash
screen -ls
```

**If you see "nexus" in the list = Script works! ✅**

### Part D: Set to Run on Boot

**1. Open crontab:**
```bash
crontab -e
```

**If asked which editor:** Choose **nano** (usually option 1)

**2. Add this line at the bottom:**
```bash
@reboot /home/YOUR_USERNAME/start-nexus.sh
```

**⚠️ IMPORTANT:** Replace `YOUR_USERNAME` with your actual username!

**Don't know your username? Check with:**
```bash
whoami
```

**3. Save crontab:**
- Press `Ctrl+X`
- Press `Y`
- Press `Enter`

### Part E: Test the Auto-Start

**Reboot your computer:**
```bash
sudo reboot
```

**After computer restarts:**
1. Log back in
2. Wait 60 seconds
3. Check if node is running:
```bash
screen -ls
```

**If you see "nexus" = Auto-start works perfectly! ✅**

---

## 🛟 STEP 12: Fix Low Memory Problems

**Is your node crashing with "Out of Memory" errors?** Add swap space (uses hard drive as extra RAM)!

### Create Swap File (16GB)

**Copy these commands ONE AT A TIME:**

**1. Create the file:**
```bash
sudo fallocate -l 16G /swapfile
```

**2. Set permissions:**
```bash
sudo chmod 600 /swapfile
```

**3. Format as swap:**
```bash
sudo mkswap /swapfile
```

**4. Turn on swap:**
```bash
sudo swapon /swapfile
```

**5. Make it permanent:**
```bash
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Check If Swap Works

```bash
free -h
```

**Look for "Swap:" line - should show 16GB**

**If you see 16G under Swap = SUCCESS! ✅**

Now your node won't crash from low memory!

---

## ⚡ Advanced Commands & Optimization

### See All Available Commands

```bash
nexus-network --help
```

This shows all available options and flags you can use.

### Manual Node Management

If you prefer to manage your node ID manually:

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

### Logout and Clear Credentials

**If you need to unlink your node:**
```bash
nexus-network logout
```

This removes stored credentials from `~/.nexus/config.json`

### Check Your Node Configuration

**View your current config:**
```bash
cat ~/.nexus/config.json
```

This shows your node ID and settings.

### Performance Tips

**1. Monitor Resource Usage:**
```bash
htop
```
**If htop not installed:**
```bash
sudo apt install htop
htop
```

Press `Q` to exit htop.

**2. Check CPU Usage:**
```bash
top
```
Press `Q` to exit top.

**3. Check Disk Space:**
```bash
df -h
```

**4. Check Internet Speed:**
```bash
speedtest-cli
```
**If not installed:**
```bash
sudo apt install speedtest-cli
speedtest-cli
```

### Optimization Checklist

To get maximum performance from your node:

- ✅ **Close unnecessary programs** - Give more resources to your node
- ✅ **Use SSD storage** - Faster than HDD
- ✅ **Stable internet** - Wired connection better than WiFi
- ✅ **Keep system updated** - Run `sudo apt update && sudo apt upgrade` weekly
- ✅ **Monitor temperatures** - Make sure computer isn't overheating
- ✅ **Add swap if RAM < 12GB** - Follow Step 12
- ✅ **Run 24/7** - More uptime = more points

### Finding Your Node IP

**To get your server's IP address:**
```bash
hostname -I
```

**Or for more details:**
```bash
ip addr show
```

**For public IP (if behind router):**
```bash
curl ifconfig.me
```

This shows the IP address other computers use to reach you.

---

## 💰 How You Earn Rewards

### NEX Testnet Points
- **What:** Points you earn for running your node
- **How:** Automatically while node is running and linked to your account
- **Check:** Login to [app.nexus.xyz](https://app.nexus.xyz)

### NEX Testnet Tokens
- **What:** Tokens you can claim from your points
- **How:** Claim them from your dashboard
- **Value:** These are TEST tokens (real value comes with Mainnet later!)

### How to Earn More Points

**Run 24/7** - The more hours your node runs, the more you earn!

**Keep it linked** - Anonymous nodes don't earn anything

**Good hardware** - Faster CPU = more computations = more points

**Stable internet** - Less disconnections = more points

**Multiple devices** - You can run up to 100 nodes on one account!

### Check Your Earnings

1. Go to **[app.nexus.xyz](https://app.nexus.xyz)**
2. Log in
3. See:
   - Total Points Earned
   - Tokens Available to Claim
   - Your Rank on Leaderboard
   - Node Performance

### Important Notes

- **Old points don't carry over** - Testnet III points are separate from older testnets
- **This is testing** - Real tokenomics come with Mainnet
- **Point rates may change** - This is a test phase
- **Keep earning** - The more you contribute now, the better position for Mainnet!

---

## 🔧 Troubleshooting - Fix Common Problems

### Problem: "Command Not Found"

**Solution:**

1. Close terminal completely
2. Open new terminal
3. Try this:
```bash
source ~/.bashrc
nexus-network --help
```

4. Still not working? Reinstall:
```bash
curl https://cli.nexus.xyz/ | sh
source ~/.bashrc
```

---

### Problem: "Node Won't Connect"

**Check your internet first:**
```bash
ping -c 4 google.com
```

**If internet works, restart node:**
```bash
screen -X -S nexus quit
screen -S nexus
nexus-network start
```

Press `Ctrl+A` then `D` to detach.

**Wait 5-10 minutes** - First connection can be slow!

---

### Problem: "Node Not in Dashboard"

**Make sure it's linked:**

1. Stop node: `screen -X -S nexus quit`
2. Run: `nexus-network`
3. Choose to link to account
4. Log in
5. Start node again
6. Wait 5 minutes and refresh dashboard

---

### Problem: "Screen Session Not Found"

**Check what sessions exist:**
```bash
screen -ls
```

**No sessions? Create one:**
```bash
screen -S nexus
nexus-network start
```

Press `Ctrl+A` then `D`

---

### Problem: "Auto-Start Not Working"

**Check the log:**
```bash
cat ~/nexus-startup.log
```

**Check crontab:**
```bash
crontab -l
```

**Should see:** `@reboot /home/YOUR_USERNAME/start-nexus.sh`

**Test script manually:**
```bash
~/start-nexus.sh
```

Wait 60 seconds, then:
```bash
screen -ls
```

---

### Problem: "Out of Memory / Node Crashes"

**Solution: Add swap space!**

Follow **STEP 12** above to create 16GB swap file.

**Also try:**
- Close other programs
- Restart computer
- Check RAM usage: `free -h`

---

### Problem: "Low Points / Slow Earning"

**Common causes:**

✅ **Node keeps disconnecting** - Check internet stability

✅ **Node not running 24/7** - Use screen and auto-start

✅ **Slow CPU** - This is normal, just keep running!

✅ **Not linked to account** - Anonymous nodes earn nothing!

**Check if earning:**
- Go to app.nexus.xyz
- Log in
- Check if points are increasing

---

### Problem: "Can't See Node Running"

**Check all processes:**
```bash
ps aux | grep nexus
```

**Should see:** nexus-network process running

**Check screen sessions:**
```bash
screen -ls
```

**Monitor resources:**
```bash
htop
```

(Press `Q` to exit)

---

## 🎯 Quick Command Cheat Sheet

### Node Commands

| What You Want To Do | Command |
|---------------------|---------|
| Start node (test) | `nexus-network start` |
| See all options | `nexus-network --help` |
| Stop node | Press `Ctrl+C` |
| Link to account | `nexus-network` (then follow prompts) |
| Logout/unlink | `nexus-network logout` |

### Screen Commands

| What You Want To Do | Command |
|---------------------|---------|
| Create session | `screen -S nexus` |
| List sessions | `screen -ls` |
| View node | `screen -r nexus` |
| Leave running | `Ctrl+A` then `D` |
| Stop node | `screen -X -S nexus quit` |

### System Commands

| What You Want To Do | Command |
|---------------------|---------|
| Check RAM | `free -h` |
| Check resources | `htop` |
| Check disk space | `df -h` |
| Check internet | `ping google.com` |
| Your username | `whoami` |
| Your IP | `hostname -I` |
| Check log | `cat ~/nexus-startup.log` |

### One-Liner Restart

**Quick restart everything:**
```bash
screen -X -S nexus quit && screen -S nexus && nexus-network start
```

Then press `Ctrl+A` then `D`

---

## 🌐 Important Links

- **Nexus Dashboard:** [app.nexus.xyz](https://app.nexus.xyz)
- **Node Management:** [app.nexus.xyz/nodes](https://app.nexus.xyz/nodes)
- **Official Documentation:** [docs.nexus.xyz](https://docs.nexus.xyz)
- **GitHub Repository:** [github.com/nexus-xyz/nexus-cli](https://github.com/nexus-xyz/nexus-cli)
- **Discord Community:** [discord.gg/nexus-xyz](https://discord.gg/nexus-xyz)
- **Report Issues:** [GitHub Issues](https://github.com/nexus-xyz/nexus-cli/issues)

---

## ❓ Common Questions

### Can I Run Multiple Nodes?

**YES!** You can run up to **100 nodes** on one account.

- Different computers = different nodes
- All managed from one dashboard
- **Limit:** 50 new nodes per day
- **Total max:** 100 nodes total

### Do I Need Terminal Open?

**NO!** That's why we use **screen**.

Screen keeps your node running when:
- ✅ You close the terminal
- ✅ You log out
- ✅ You disconnect from SSH

### How Much Can I Earn?

**It depends on:**
- Your CPU speed (faster = more points)
- Your RAM (more = better)
- Uptime (24/7 is best)
- Network demand

**Best practice:** Run 24/7 on multiple computers!

### What is zkVM?

**Simple:** It's special technology that proves your computer did the work correctly.

**Technical:** Zero Knowledge Virtual Machine - uses cryptography to verify computations without revealing the data.

**Why it matters:** Makes blockchain faster and more secure!

### Is This Safe?

**YES!**
- ✅ Code is open-source (anyone can review it)
- ✅ Runs in safe sandbox
- ✅ Only processes assigned work
- ✅ No access to your files
- ✅ Can't harm your computer

### Will This Damage My Computer?

**NO!** But:
- Uses CPU and RAM (normal computing)
- Computer might get warm (normal)
- Uses electricity (like any program)
- Might slow down other programs a bit

**Tip:** Make sure computer has good cooling!

### Can I Run Other Programs?

**YES!** Your computer can do other things while running the node.

**But:** Node works best when:
- Not too many other programs running
- Computer has enough RAM
- Internet not being heavily used

### When Does Mainnet Launch?

**Not announced yet!**

- Currently in Testnet III (testing phase)
- Mainnet coming later
- Keep running to be ready for mainnet rewards!

### What Happens to My Test Tokens?

**These are TEST tokens** for Testnet III.

- Real tokenomics come with Mainnet
- Keep earning now = better position later
- Official info will come from Nexus team

### Can I Use Windows?

**The official CLI is for Linux.**

But you can:
- Use WSL (Windows Subsystem for Linux)
- Use the web browser version at app.nexus.xyz
- Run Linux VM on Windows

**Easiest:** Use browser version for Windows!

---

## ⚠️ IMPORTANT WARNINGS - READ THIS!

### 🚨 SCAM ALERT 🚨

**Nexus support will NEVER:**
- ❌ Send you a private message first
- ❌ Ask for your password or private keys
- ❌ Send you a "support ticket" in DMs
- ❌ Ask you to send money or crypto
- ❌ Message you on Telegram/Discord/Twitter DMs

**If someone messages you claiming to be support:**
### IT IS 100% A SCAM! 🚫

**Real support is ONLY:**
- ✅ Discord public channels
- ✅ GitHub issues
- ✅ Official docs at docs.nexus.xyz

### Third-Party Services Warning

**Some companies sell "ready-made" nodes.**

⚠️ **Before buying:**
- Research the company
- Check reviews
- Understand Nexus can't help with third-party issues
- Support must come from the seller

**Many scams exist!** Be careful!

### Protect Yourself

**NEVER share:**
- Your password
- Your private keys
- Your wallet seed phrase
- Your login codes

**ALWAYS verify:**
- Links are official (nexus.xyz domain)
- You're on the real website
- Messages are from official accounts

---

## ✅ Final Checklist - Make Sure Everything Works!

**Before you finish, check these:**

### 1. Node is Running
```bash
screen -ls
```
✅ You should see "nexus" in the list

### 2. Can View Your Node
```bash
screen -r nexus
```
✅ You should see activity and computations

Press `Ctrl+A` then `D` to leave it running

### 3. Node Shows in Dashboard
- Go to [app.nexus.xyz/nodes](https://app.nexus.xyz/nodes)
- ✅ Your node appears in the list
- ✅ Shows "Active" or "Online"

### 4. Points Are Increasing
- Check [app.nexus.xyz](https://app.nexus.xyz)
- ✅ Points number is going up (check after a few hours)

### 5. Auto-Start Works (Optional)
```bash
cat ~/nexus-startup.log
```
✅ Shows recent startup times (if you set this up)

### Quick Test Checklist

Run these commands and check results:

```bash
# Should show nexus session
screen -ls

# Should show 16GB (if you added swap)
free -h

# Should show your node config
cat ~/.nexus/config.json

# Should show nexus processes
ps aux | grep nexus
```

**If all checks pass = YOU'RE ALL SET! 🎉**

---

## 🎉 Congratulations! You're Earning!

**Your Nexus node is now running and earning NEX Testnet Points!**

### What Happens Now?

✅ **Your node runs 24/7** earning points automatically

✅ **Check dashboard weekly** at app.nexus.xyz

✅ **Points turn into tokens** that you can claim

✅ **Get ready for Mainnet** where real rewards begin!

### Tips for Maximum Earnings

**Keep it running:**
- Don't stop your node
- Monitor it once a week
- Fix issues quickly

**Optimize performance:**
- Close unused programs
- Keep system updated: `sudo apt update && sudo apt upgrade`
- Maintain stable internet
- Monitor temps (keep computer cool)

**Grow your network:**
- Run nodes on multiple computers
- All managed from one account
- Up to 100 nodes total!

**Stay informed:**
- Join Discord community
- Follow official announcements
- Watch for Mainnet news

### Weekly Maintenance (5 minutes)

**Do this once a week:**

1. **Check node is running:**
```bash
screen -ls
```

2. **View dashboard:**
- Go to app.nexus.xyz
- Check points are increasing
- Verify node shows "Active"

3. **Check resources:**
```bash
free -h
htop
```

4. **Update system:**
```bash
sudo apt update && sudo apt upgrade -y
```

**That's it!** Just 5 minutes a week!

---

## 🌟 You're Contributing to the Future!

By running a Nexus node, you're:
- 💻 Helping build verifiable internet
- 🚀 Supporting cutting-edge zkVM technology
- 💰 Earning rewards for your contribution
- 🌐 Part of a global network

**Thank you for being an early adopter!**

---

## 📞 Need Help?

### Official Support Channels:

**Discord:** [discord.gg/nexus-xyz](https://discord.gg/nexus-xyz)
- ✅ Active community
- ✅ Quick help from other node runners
- ✅ Official announcements

**GitHub Issues:** [github.com/nexus-xyz/nexus-cli/issues](https://github.com/nexus-xyz/nexus-cli/issues)
- ✅ Report technical problems
- ✅ Request features
- ✅ Bug tracking

**Documentation:** [docs.nexus.xyz](https://docs.nexus.xyz)
- ✅ Official guides
- ✅ FAQ
- ✅ Technical details

**Dashboard:** [app.nexus.xyz](https://app.nexus.xyz)
- ✅ Manage nodes
- ✅ Check earnings
- ✅ Claim tokens

### Remember:
- 🚫 Support NEVER DMs you first
- 🚫 Don't share passwords or keys
- 🚫 Beware of scams
- ✅ Only use official channels above

---

## 📊 Your Node Stats

**Keep track of your performance:**

| Stat | Where to Check |
|------|----------------|
| Points Earned | app.nexus.xyz dashboard |
| Node Status | app.nexus.xyz/nodes |
| CPU Usage | `htop` command |
| RAM Usage | `free -h` command |
| Uptime | Dashboard or `uptime` command |
| Rank | app.nexus.xyz leaderboard |

---

**Questions about this guide?**
- Created with ❤️ for the Nexus community
- Updated: October 2025
- Version: 2.0 (Simplified)

**Stay connected. Keep earning. Welcome to Nexus Network! 🚀**

---

*Last Updated: October 2025 - Testnet III*

*Guide by bokiko - [github.com/bokiko](https://github.com/bokiko)*
