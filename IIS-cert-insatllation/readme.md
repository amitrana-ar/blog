# 🌐 IIS SSL Certificate Documentation  
### Using ZeroSSL & win-acme (Let’s Encrypt) – Complete Guide

This document explains how to generate and install SSL certificates on IIS using **two different methods**:

- **Method 1:** Generate SSL using **ZeroSSL** with DNS verification  
- **Method 2:** Generate SSL using **win-acme (Let’s Encrypt)** on Windows Server with IIS  

This README is meant for internal documentation and future reference for troubleshooting, certificate renewals, and SSL setup on IIS.

---

# 📌 Method 1 — Generate SSL Certificate Using ZeroSSL (DNS CNAME Verification)

Follow these steps to issue a 90‑day free SSL certificate from ZeroSSL.

---

## ✅ Steps

### 1. Login to ZeroSSL  
Open: https://app.zerossl.com/login  
Login using your credentials.

---

### 2. Create New Certificate  
1. Click **New Certificate**  
2. Enter domain name (example: `thesahilsen.shop`) → **Next**

---

### 3. Choose Certificate Type  
- Select **90 Days (Free)** → Next  

---

### 4. Addons  
- Keep all add‑ons disabled (default) → Next  

---

### 5. CSR & Contact  
- Choose **Auto Generate CSR** (default) → Next  

---

### 6. Encryption Algorithm  
Choose:

```
RSA 2048 (Default)
```

Click **Next**

---

### 7. Finalize Order  
- Select **Free** → Next  

---

### 8. Domain Verification (DNS CNAME)  
- Choose **DNS (CNAME)**  
- ZeroSSL will show a CNAME record  
- Add that CNAME to your DNS provider  
- Click **Next**

Example:

```
Type: CNAME  
Host: _acme-challenge.example.com  
Value: <value provided by ZeroSSL>
```

---

### 9. Verification  
Once DNS propagates:

✔️ Domain becomes **verified**  
✔️ SSL certificate becomes available for download  

You will receive:  
- Certificate (CRT)  
- CA Bundle  
- Private Key  

---

# 📌 Method 2 — Generate IIS SSL Certificate Using win‑acme (Let’s Encrypt)

The win‑acme client allows Windows servers to automatically create and renew **Let’s Encrypt certificates**. This method updates IIS bindings automatically.

---

## 🔧 Requirements  
- Windows Server  
- IIS installed  
- Domain must point to the server  
- Port 80 must be open  

Download win‑acme:  
https://www.win-acme.com/

---

## ✅ Steps

### 1. Open win‑acme  
```powershell
cd C:\win-acme
wacs.exe
```

---

### 2. Select Advanced Mode  
Choose:

```
M: Create certificate (full options)
```

---

### 3. Select Domain Input Method  
Choose:

```
2: Manual input
```

Enter domain:
```
arworld.life
```

Press Enter to accept friendly name.

---

### 4. Choose Certificate Splitting  
Choose:

```
1: Separate certificate for each domain
```

---

### 5. Choose Validation Method  
Options displayed include HTTP, FTP, DNS, ALPN.

Choose HTTP‑based:

```
2: Serve verification files from memory
```

(This works because your domain resolves correctly to the server.)

---

### 6. Choose Private Key Type  
Choose:

```
2: RSA key
```

---

### 7. Choose Where to Store Certificate  
Select Windows certificate store:

```
4: Windows Certificate Store (Local Computer)
```

Then choose:

```
1: WebHosting store
```

---

### 8. IIS Installation Step  
Choose:

```
1: Create or update bindings in IIS
```

Select your IIS website:

```
1: arworld.life
```

This will automatically:

- Add HTTPS binding  
- Attach certificate to IIS  
- Enable SSL on port 443  

---

### 9. Terms of Service  
You will be asked to:

- Open Let’s Encrypt TOS PDF  
- Agree to the terms  
- Enter your email  

Example:

```
Email: rana.amit23028@gmail.com
```

---

### 10. Certificate Issuance  
If successful, you will see:

```
Authorization result: valid
Certificate created
Bindings updated in IIS
Scheduled task created for auto-renewal
Next renewal date shown
```

A Windows Task Scheduler entry is created to auto‑renew the certificate.

---

# 🎉 Final Result  
✔️ SSL certificate installed in IIS  
✔️ HTTPS binding added  
✔️ Auto-renew task created  
✔️ Domain secured with Let’s Encrypt  

---

# 🛠 Troubleshooting Notes

### Domain not validating?
- Check DNS A record  
- Ensure port 80 is open  
- Ensure IIS site is running  

### win‑acme cannot find IIS bindings?
- Add the domain binding in IIS first  
- Ensure binding on port 80 exists  

### Auto-renew not working?
- Check Task Scheduler  
- Ensure SYSTEM account has permissions  

---

# 📘 Purpose of This Documentation  
This file is part of the internal **Blog / Documentation Repository**, where we document:

- Issues we face  
- Steps we follow  
- Troubleshooting  
- Final solutions  

This ensures fast recovery and knowledge sharing for future issues.

---

# ✔️ End of Document
