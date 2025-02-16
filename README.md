# ECS with Fargate - Infrastructure as Code

## Overview
This repository contains Infrastructure as Code (IaC) to provision and manage AWS ECS (Elastic Container Service) using Fargate as the runtime environment. It also includes additional resources for application deployment, including an RDS database, an ECR repository, and a CI/CD pipeline.

## Folder Structure
```
.
├── provision-resources/
│   ├── rds.tf          # Scripts to provision RDS database
│   ├── ecr.tf          # Setup for Elastic Container Registry
│   ├── pipeline.tf     # CI/CD pipeline configuration
├── deployment              # ECS cluster and service definitions
```

## Features
- **ECS with Fargate**: Fully managed container orchestration.
- **RDS**: Managed database service for storing application data.
- **ECR**: Secure container registry for storing Docker images.
- **CI/CD Pipeline**: Automates application deployment.
- **Scalability**: Easily scales based on workload.
- **Security**: IAM roles and policies for secure access control.

## Prerequisites
- AWS CLI installed and configured
- Terraform or AWS CloudFormation (if using Infrastructure as Code)
- Docker (for building container images)

## Deployment Steps
1. **Clone the repository**
   ```sh
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Provision resources**
   - Navigate to the `provision-resources` folder and deploy required infrastructure (RDS, ECR, pipeline):
   ```sh
   cd terraform/provision-resources
   terraform init
   terraform plan
   terraform apply 
   ```

3. **Deploy ECS with Fargate**
   - Configure the ECS cluster and services in the `deployment/` directory.
   ```sh
   cd terraform/deployment
   terraform init
   terraform plan
   terraform apply
   ```

4. **Push container image to ECR**
   ```sh
   aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <ecr-repo-url>
   docker build -t <image-name> .
   docker tag <image-name>:latest <ecr-repo-url>:latest
   docker push <ecr-repo-url>:latest
   ```

5. **Trigger the CI/CD pipeline**
   - The pipeline will deploy the application automatically.

## Monitoring & Logs
- **CloudWatch Logs**: View logs for ECS tasks and services.
- **AWS X-Ray**: Trace application performance (if enabled).
- **ECS Console**: Monitor running tasks and services.

## Future Enhancements
- Add autoscaling for ECS tasks
- Implement Blue/Green deployment strategy
- Enhance security with AWS Secrets Manager
---
Feel free to contribute and enhance this repository!

