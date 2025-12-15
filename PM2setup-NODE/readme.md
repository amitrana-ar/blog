# PM2 Complete Guide (From Scratch to Production)

This document is a clean, practical, production-focused guide for using PM2 with Node.js on Ubuntu (AWS EC2 or any Linux server).

---

## 1. What is PM2?

PM2 is a production process manager for Node.js applications.

It:
- Runs Node.js apps in the background
- Restarts apps automatically if they crash
- Starts apps automatically after server reboot
- Provides logs, CPU, and memory monitoring

---

## 2. Why PM2 is Required

Without PM2:
- App stops when SSH session closes
- App stops on crash
- App does not start after reboot

With PM2:
- App runs 24x7
- Auto-restart on crash
- Auto-start after reboot

---

## 3. Prerequisites

Ubuntu Linux  
Node.js installed  
npm installed  

Check:
node -v  
npm -v  

---

## 4. Install PM2

Install PM2 globally:
sudo npm install -g pm2

Verify:
pm2 -v

---

## 5. Create a Sample Node.js App

mkdir pm2-app  
cd pm2-app  
npm init -y  
npm install express  

index.js:
```js
const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("PM2 app is running");
});

app.listen(3000, () => {
  console.log("App running on port 3000");
});
```

---

## 6. Start App with PM2

pm2 start index.js --name pm2-app  
pm2 status  

---

## 7. Common PM2 Commands

pm2 status  
pm2 restart pm2-app  
pm2 stop pm2-app  
pm2 delete pm2-app  
pm2 logs pm2-app  

---

## 8. PM2 Logs

Logs location:
~/.pm2/logs/

Log files:
pm2-app-out.log  
pm2-app-error.log  

View logs:
pm2 logs pm2-app  

---

## 9. Enable Auto Start on Reboot

pm2 startup  
(run the command PM2 prints)

pm2 save  

---

## 10. Log Rotation Problem

PM2 logs grow endlessly by default and can fill disk space.

---

## 11. Install PM2 Logrotate

pm2 install pm2-logrotate  

---

## 12. Configure Log Rotation

pm2 set pm2-logrotate:max_size 2M  
pm2 set pm2-logrotate:retain 5  
pm2 set pm2-logrotate:compress true  
pm2 set pm2-logrotate:rotateInterval '0 0 * * *'  

---

## 13. How Log Rotation Works

Current log:
pm2-app-out.log  

Rotated logs:
pm2-app-out.log.1.gz  
pm2-app-out.log.2.gz  

Old logs are compressed and removed automatically.

---

## 14. Reduce Log Noise (Developer Side)

Use environment-based logging:
```js
const isProd = process.env.NODE_ENV === "production";

function logDebug(msg) {
  if (!isProd) console.log(msg);
}

function logError(err) {
  console.error(err);
}
```

Run in production:
pm2 start index.js --name pm2-app --env production  

---

## 15. Emergency Log Cleanup

pm2 flush  

---

## 16. Best Practices Summary

- Use PM2 for production Node.js apps
- Enable auto-start on reboot
- Rotate logs using pm2-logrotate
- Control logging in application code
- Avoid manual log deletion

---

End of Document
