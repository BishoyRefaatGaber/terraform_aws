# AWS Infrastructure Automation with Terraform

A Terraform project that provisions a secure, multi-tier AWS environment with public/private subnets, load balancers, and automated provisioning. Designed to fulfill the requirements of **Lab3.pdf**.

---

## 🚀 Project Overview

This project automates the deployment of a scalable AWS infrastructure that includes:
- **Isolated Environments**: Public and private subnets for enhanced security.
- **Load Balancing**: A public-facing Application Load Balancer (ALB) and a private internal ALB.
- **Auto-Provisioned Services**: Apache/web server installed automatically on EC2 instances.
- **State Management**: Remote Terraform state storage in an S3 bucket.
- **IP Tracking**: Exports instance public IPs to `all-ips.txt` for easy access.

---

## 📋 Key Features

| Requirement                                | Implementation Details                                                                 |
|--------------------------------------------|---------------------------------------------------------------------------------------|
| **Workspace Management**                   | Uses a dedicated `dev` workspace (not default).                                       |
| **Custom Modules**                         | Private Terraform modules for VPC, EC2, ALB (non-public, stored locally).             |
| **Remote State**                           | State file stored securely in an S3 bucket.                                           |
| **Automated Provisioning**                 | Uses `remote-exec` to install Apache/proxy and `local-exec` to write IPs to a file.   |
| **AMI Data Source**                        | Dynamically fetches the latest Ubuntu AMI ID for EC2 instances.                       |
| **Load Balancers**                         | Public ALB for external traffic, private ALB for internal routing.                    |
| **GitHub Submission**                      | Includes code, infrastructure diagrams, and required screenshots (see below).         |

---

## 📐 Infrastructure Diagram

### VPC: `10.0.0.0/16`
| Public Subnet (`10.0.0.0/24`)         | Private Subnet (`10.0.1.0/24`)          |
|---------------------------------------|------------------------------------------|
| Security Group (Proxy)                | Security Group (Backend)                 |
| Proxy EC2 Instance                    | Private Backend EC2 Instances            |

### Public Subnet: `10.0.2.0/24`
| Public Subnet (`10.0.3.0/24`)         | Private Subnet (`10.0.3.0/24`)          |
|---------------------------------------|------------------------------------------|
| Security Group (Proxy)                | Security Group (Backend)                 |
| Proxy EC2 Instance                    | Private Backend EC2 Instances            |

---

## 🛠️ Prerequisites
- **Terraform v1.0+** installed.
- **AWS CLI** configured with valid IAM credentials.
- IAM permissions for **EC2, VPC, S3, and NLB**.

---

## 🚦 Getting Started

1. **Clone the Repository**:
   ```bash
   git clone <your-github-uri>
   cd <repo-directory>







![Screenshot from 2025-04-08 11-23-13](https://github.com/user-attachments/assets/7a3341e7-a5f2-44ef-a240-d938aa9b6db6)


![Screenshot from 2025-04-08 11-17-28](https://github.com/user-attachments/assets/88b8b020-14ab-4c8c-892a-79bd6805a039)


![Screenshot from 2025-04-08 11-16-00](https://github.com/user-attachments/assets/ae69cf41-f64a-421a-8bb4-437367aa593c)


![Screenshot from 2025-04-08 11-19-23](https://github.com/user-attachments/assets/3204b4a3-e80a-4a5f-befa-51841401b16b)


![Screenshot from 2025-04-08 11-19-54](https://github.com/user-attachments/assets/6cc41055-11cb-44e8-a5a6-56a16ae2a282)


![Screenshot from 2025-04-08 11-14-34](https://github.com/user-attachments/assets/c20337c2-c3ee-468e-84de-133bdf2c99cb)
