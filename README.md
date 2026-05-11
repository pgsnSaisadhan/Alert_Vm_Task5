# 🚀 Azure VM Monitoring & Stress Testing Project

## 📌 Overview
This project automates Azure infrastructure provisioning using Terraform and implements monitoring with Azure Monitor alerts. It also includes a stress testing pipeline using GitHub Actions to validate CPU and memory alerting.

---

## 🏗️ Architecture Flow
GitHub Actions → Terraform → Azure VM → Stress Test → Azure Monitor Alerts → Email Notification

---

## ⚙️ Tech Stack
- Terraform (Infrastructure as Code)
- Azure Virtual Machines
- Azure Monitor
- GitHub Actions (CI/CD)
- Bash (stress testing)
- Linux (Ubuntu VM)

---

## 📦 Infrastructure Created
- Resource Group
- Virtual Network (VNet)
- Subnet
- Network Security Group (NSG)
- Public IP
- Linux Virtual Machine
- Action Group (Email alerts)
- Metric Alerts (CPU + Memory)

---

## 🚨 Monitoring Alerts
- CPU > 75% → Warning Alert
- CPU > 95% → Critical Alert
- Memory Low → Warning/Critical Alert

---

## ⚡ Stress Test
Triggered via GitHub Actions:
- CPU load test
- Memory load test
- Disk stress test

Tool used:
```bash
stress --cpu 8 --vm 4 --vm-bytes 2G --timeout 300