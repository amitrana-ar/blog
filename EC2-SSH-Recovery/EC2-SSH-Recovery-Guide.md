# 🔐 EC2 SSH Key Recovery Guide (Lost PEM Key Solution)

This repository provides a complete, step-by-step procedure to **recover SSH access** to an AWS EC2 instance when the original PEM key is lost.

The method used is the official AWS-recommended approach:
➡️ **Detach root volume → mount on a temporary EC2 → inject new SSH key → reattach volume**

This guide works for:
- Ubuntu
- Amazon Linux
- CentOS / RHEL
- Any Linux-based EC2 instance

---

## 📌 Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Steps](#steps)
    - [1. Create New Key Pair](#step-1--create-a-new-key-pair)
    - [2. Stop Original Instance](#step-2--stop-the-original-instance)
    - [3. Detach Root Volume](#step-3--detach-the-root-volume)
    - [4. Launch Temporary EC2 Instance](#step-4--prepare-a-temporary-ec2-instance)
    - [5. Attach Detached Volume](#step-5--attach-the-detached-volume-to-the-temporary-ec2)
    - [6. SSH Into Temporary EC2](#step-6--ssh-into-the-temporary-ec2)
    - [7. Mount Original Volume](#step-7--identify-and-mount-the-attached-disk)
    - [8. Add SSH Key](#step-8--insert-your-new-ssh-public-key)
    - [9. Fix Permissions](#step-9--fix-permissions)
    - [10. Unmount + Detach Volume](#step-10--unmount-and-detach-the-volume)
    - [11. Reattach to Original EC2](#step-11--reattach-the-volume-to-original-ec2)
    - [12. Start Instance + Login](#step-12--start-original-ec2-and-login)
4. [Summary Cheat Sheet](#summary-cheat-sheet)
5. [License](#license)

---

## 🧩 Overview
If your PEM key is lost, SSH access to EC2 is impossible.  
AWS does not allow downloading keys again—so access must be restored manually.

This guide shows how to:

1. Create a new SSH key pair  
2. Attach the instance’s root volume to another EC2  
3. Inject the new key into `authorized_keys`  
4. Reattach the volume and regain access  

---

## 🧰 Prerequisites
Before starting, ensure you have:

- AWS Console access  
- Ability to stop/start EC2 instances  
- Temporary EC2 instance (helper server)  
- Basic SSH knowledge  

---

# 🟦 Steps

---

## STEP 1 — Create a New Key Pair
1. Go to **EC2 → Key Pairs**  
2. Click **Create key pair**  
3. Name: `recovery-key`  
4. Type: RSA  
5. Format: `.pem`  
6. Download the key

---

## STEP 2 — Stop the Original Instance
Go to **Instances → Stop Instance**.  
You must stop it to detach the volume.

---

## STEP 3 — Detach the Root Volume
1. Open the instance → **Storage** tab  
2. Click the root volume ID  
3. Choose **Actions → Detach volume**  
4. Wait until status becomes **available**

---

## STEP 4 — Prepare a Temporary EC2 Instance
Launch a small Ubuntu or Amazon Linux instance:

- Must be in **same Availability Zone**  
- Must be **running**  
- You must have SSH access to it  

---

## STEP 5 — Attach the Detached Volume to the Temporary EC2
1. Go to **EC2 → Volumes**  
2. Select the detached volume  
3. Click **Actions → Attach volume**  
4. Choose the temporary EC2  
5. Device name: `/dev/xvdf`

AWS will map it internally as something like `/dev/nvme1n1`.

---

## STEP 6 — SSH Into the Temporary EC2
```bash
ssh -i temp-key.pem ubuntu@<temp-ec2-ip>
```

---

## STEP 7 — Identify and Mount the Attached Disk
List disks:

```bash
lsblk
```

You should see:

```
nvme0n1      -> temp EC2 disk
nvme1n1      -> original EC2 disk
```

Mount:

```bash
sudo mkdir /mnt/recovery
sudo mount /dev/nvme1n1p1 /mnt/recovery
```

Confirm:

```bash
ls /mnt/recovery
```

---

## STEP 8 — Insert Your New SSH Public Key

Get your public key from the new PEM (on your local machine):

```bash
ssh-keygen -y -f recovery-key.pem
```

Copy the output.

---

### Add it to authorized_keys

For Ubuntu:

```bash
sudo nano /mnt/recovery/home/ubuntu/.ssh/authorized_keys
```

For Amazon Linux:

```bash
sudo nano /mnt/recovery/home/ec2-user/.ssh/authorized_keys
```

Paste → Save → Exit.

---

## STEP 9 — Fix Permissions
```bash
sudo chmod 700 /mnt/recovery/home/ubuntu/.ssh
sudo chmod 600 /mnt/recovery/home/ubuntu/.ssh/authorized_keys
```

---

## STEP 10 — Unmount and Detach the Volume
Unmount:

```bash
sudo umount /mnt/recovery
```

Detach via AWS Console.

---

## STEP 11 — Reattach the Volume to Original EC2
1. Select the volume  
2. Click **Attach volume**  
3. Choose the original EC2 instance  
4. Device name: `/dev/xvda`

---

## STEP 12 — Start Original EC2 and Login

### Ubuntu:
```bash
ssh -i recovery-key.pem ubuntu@<public-ip>
```

### Amazon Linux:
```bash
ssh -i recovery-key.pem ec2-user@<public-ip>
```

🎉 Access fully restored!

---

# Summary Cheat Sheet

| Step | Description |
|------|-------------|
| 1 | Create new key pair |
| 2 | Stop original EC2 |
| 3 | Detach root volume |
| 4 | Launch temporary EC2 |
| 5 | Attach volume to temporary EC2 |
| 6 | SSH into temporary EC2 |
| 7 | Mount `/dev/nvme1n1p1` |
| 8 | Add SSH public key |
| 9 | Fix permissions |
| 10 | Unmount & detach |
| 11 | Attach to original EC2 |
| 12 | Start instance & SSH |

---

# License
This project is released under the **MIT License**.
