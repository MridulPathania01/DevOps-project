# ☁️ Secure Cloud Infrastructure & Flask Deployment

![Status](https://img.shields.io/badge/Status-Completed-success)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![Docker](https://img.shields.io/badge/Docker-Containerization-blue)
![Flask](https://img.shields.io/badge/Python-Flask-green)
![CI/CD](https://img.shields.io/badge/GitHub_Actions-Pipeline-black)

## 📖 Overview

This project demonstrates a full-stack approach to deploying a Python Flask application using modern DevOps practices. The core objective is to provision secure, scalable cloud infrastructure on AWS using **Terraform** (Infrastructure as Code) and automate the deployment lifecycle using **GitHub Actions**.

The application consists of a Flask REST API and a lightweight HTML frontend, containerized with Docker to ensure consistency across development and production environments.

## 🚀 Key Features

* **Infrastructure as Code (IaC):** Automated resource provisioning on AWS (EC2/ECS, Security Groups, IAM) using Terraform.
* **Containerization:** Full Docker integration for modularity and portability.
* **CI/CD Pipeline:** Automated build, test, and deployment workflows triggered via GitHub Actions.
* **Security First:** Configuration management using environment variables to protect sensitive credentials.
* **Scalability:** Designed to handle backend requests efficiently via a robust API structure.

## 🛠️ Tech Stack

| Category | Technology |
| :--- | :--- |
| **Language** | Python 3.9+ |
| **Framework** | Flask |
| **Containerization** | Docker |
| **Infrastructure** | Terraform |
| **Cloud Provider** | Amazon Web Services (AWS) |
| **CI/CD** | GitHub Actions |
| **Frontend** | HTML5 / Jinja2 |

## ✅ Development Roadmap & Status

| ID | Component | Description | Status |
| :--- | :--- | :--- | :--- |
| **01** | **Frontend** | Create base HTML template and UI structure | ✔️ Done |
| **02** | **Backend** | Develop Python Flask API endpoints | ✔️ Done |
| **03** | **Docker** | Containerize application (Dockerfile & Compose) | ✔️ Done |
| **04** | **IaC** | Provision AWS infrastructure using Terraform | ✔️ Done |
| **05** | **Security** | Configure Environment Variables & Secrets | ✔️ Done |
| **06** | **Pipeline** | Setup GitHub Actions for CI/CD | ✔️ Done |

## ⚙️ Getting Started

Follow these instructions to set up the project locally.

### Prerequisites
* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io/)
* AWS CLI configured with credentials

### 1. Local Installation
Clone the repository

### 2. Run with Docker 
Build and run the container locally to test the API:

```bash
docker build -t flask-app .
docker run -p 5000:5000 flask-app
```

### 3. Deploy Infrastructure (Terraform)
Initialize and apply the Terraform configuration to create AWS resources:

```bash
cd terraform
terraform init
terraform plan
terraform apply










