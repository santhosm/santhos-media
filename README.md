# Media Wiki
This Repo consist of both CI/CD pipeline to deploy mediaWiki server by using following stack
- Cloud - **Azure**
- Infrastructure management - **Terraform**
- CI/CD platform - **GitHub Actions**
- Containirization - **Docker**
- Container orchestration - **Kubernetes (AKS)**
- Kube package manager - **Helm**
- Upgrade stratergy - **Rolling**

## CI Pipeline

CI Pipeline consist of Creation of Docker file and Helm chart creation

**Docker creation**
Any changes made to the path **CI/** in main branch will trigger the action **create-docker** this action will create the media server docker and push it to docker hub  https://github.com/santhosm/thoughtworks/actions/runs/3110617936/jobs/5041991152

**Helm Chart Creation**
Any changes made to the path **CI/helm** in main branch will trigger the action **create-helmr** this action will create the helm chart containing a deployemnt, Service, Ingress controller. 
https://github.com/santhosm/thoughtworks/actions/runs/3111458590/jobs/5043766510



## CD Pipeline

CD Pipeline consist of Creation of Azure infra structure and deploying Media Wiki Server

**Infra structure**
Any PR with changes made to the path **CD/terraform/infra/** will trigger the **pr-open-infra** action this will execute terraform plan.
https://github.com/santhosm/thoughtworks/actions/runs/3110252814/jobs/5041256887
Once the Plan is verified, PR is aprooved and merged it would trigger **pr-aprroved-infra** This would run terraform apply and deploy an RG and AKS cluster. 
https://github.com/santhosm/thoughtworks/actions/runs/3110255438/jobs/5041261990#step:6:74

**Media Wiki Server**
Any PR with changes made to the path **CD/terraform/media/** will trigger the **pr-open-media** action this will execute terraform plan.
https://github.com/santhosm/thoughtworks/actions/runs/3111896400/jobs/5044712285#step:10:50
Once the Plan is verified, PR is aprooved and merged it would trigger **pr-aprroved-media** This would run terraform apply and deploy helm chart of the media server created by CI pipeline. 
https://github.com/santhosm/thoughtworks/actions/runs/3111896400/jobs/5044712285#step:10:50

**Media server is available at http://20.102.27.106/mediawiki**

## Suggestions for scaling 

- Remove the DB from container and use Cloud provider DBs or use persistet disks to store the DB 