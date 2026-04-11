# Recipe Tracker - Infrastructure

Infrastructure as Code (IaaC) for the Recipe Tracker application, built as part of TU Dublin MSc DevOps CA2.

## Overview
This repo contains all infrastructure provisioning and Kubernetes deployment manifests for the Recipe Tracker microservices application.

## Tech Stack
- Terraform — Azure infrastructure provisioning
- Kubernetes — container orchestration
- Azure AKS — managed Kubernetes cluster
- Azure Container Registry — Docker image storage
- GitHub Actions — automated CD pipeline

## Infrastructure
| Resource | Details |
|----------|---------|
| Resource Group | recipe-app-rg |
| AKS Cluster | recipe-aks (2 nodes, Standard_B2s_v2) |
| Container Registry | recipeacr247.azurecr.io |
| Location | North Europe |

## Deployment Strategy
Blue/green deployment with Horizontal Pod Autoscaling (min 2, max 10 pods).

## Usage

### Provision infrastructure
```bash
terraform init
terraform plan
terraform apply
```

### Deploy to Kubernetes
```bash
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/mongo.yml
kubectl apply -f k8s/backend-blue.yml
kubectl apply -f k8s/frontend-blue.yml
kubectl apply -f k8s/services.yml
kubectl apply -f k8s/hpa.yml
```

### Stop/Start AKS cluster
```bash
# Stop (saves costs)
az aks stop --name recipe-aks --resource-group recipe-app-rg

# Start
az aks start --name recipe-aks --resource-group recipe-app-rg
```

## Architecture
```
GitHub Actions CI → Azure Container Registry → AKS Cluster
                                                    ├── recipe-frontend (Node.js)
                                                    ├── recipe-backend (Java/Spring Boot)
                                                    └── recipe-mongo (MongoDB)
```