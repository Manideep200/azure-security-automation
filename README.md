# Azure Secure-by-Design Network (Terraform)

## 📌 Project Overview
This project automates the deployment of a hardened, 2-tier network architecture on Azure using Infrastructure as Code (Terraform). The goal was to build a foundation that follows the **Principle of Least Privilege** and **Zero Trust** security models.

## 🛡️ Security Features
* **Network Segmentation:** Created isolated Public (Web) and Private (DB) subnets to prevent unauthorized lateral movement.
* **Inbound Traffic Filtering:** Configured Network Security Groups (NSGs) to allow only HTTPS (Port 443) to the public tier while blocking all direct internet access to the private database tier.
* **Security Automation:** Used Terraform variables to ensure consistent and repeatable security configurations across different environments.

## 🏗️ Architecture
* **VNet:** 10.0.0.0/16 (Global Perimeter)
* **Public Subnet:** 10.0.1.0/24 (DMZ for Web Traffic)
* **Private Subnet:** 10.0.2.0/24 (Secure Internal Database)



## 🛠️ Tools Used
* **Terraform:** For infrastructure orchestration.
* **Azure Cloud Shell:** For deployment and management.
* **Git/GitHub:** For version control and documentation.
