# legal-term-api

An HTTP API for legal terms.

## Endpoints

* `GET /terms`: list all available terms.
* `GET /definitions?term=<term>`: get the definition of a term.

## Files of Interest

1. Dockerfile present in the root of the directory.
2. local-manifest.yaml for local development
3. Pipeline config in .circleci directory
4. kubernetes-manifest.yaml file for EKS can be found in infra/modules/EKS

## Pre Requisites

You need to have the following installed

* [docker desktop](https://docs.docker.com/desktop/install/mac-install/)
* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## To run the app locally via DockerFile

1. Clone repo locally via `git clone https://github.com/paarth1995/casetext.git` 
2. `cd casetext` 
3. `docker build -t casetext .`
4. `docker run -p 8000:8000 casetext` ( use -d additionally to run as daemon)

## Enable Kubernetes via Docker Desktop

1. Open Docker Desktop
2. Click on the Gear icon in the top right corner and open settings.
3. Click on Kubernetes and select Enable Kubernetes.
4. Click on Apply and Restart.

## For local development

1. Install [minikube](https://minikube.sigs.k8s.io/docs/start/)
2. minikube start
3. Install [Kubectl](https://kubernetes.io/docs/tasks/tools/)
4. `cd casetext`
5. `kubernetes apply -f local-manifest.yaml`
6. Confirm deployment has been created : `kubectl get deployment`
7. Confirm service has been created : `kubectl get svc`
8. Run `kubectl port-forward svc/python-casetext 8000:8000` 
9. Go to http://localhost:8000/terms to access it via the browser. 

## Provision on AWS EKS and access the app publically

1. sso into your aws account.
2. `cd casetext/infra`
3. `terraform init` 
4. `terraform plan` 
5. `terraform apply`
6. Creates a VPC with the following components : VPC, 2 subnets, A SG group that allows all traffic, a route table and an internet gateway.
7. Creates an EKS cluster with a self managed node group, a deployement and a load balancer service. 
8. After `tf apply` finishes running, copy the value of `load_balancer_hostname` from the outputs.
9. Go to the browser, paste the `http://load_balancer_hostname:8000/terms` to access the API. ( Note : it may take a while to serve the page so you may have to refresh the page a couple of times.)
10. `terraform destroy` for cleanup.

## Optional : To setup your own CircleCI account

Follow these steps : https://circleci.com/docs/first-steps/

## Pipeline Overview

The pipeline is built using CircleCI. It runs the following steps : 

1. Checkout code
2. Installs poetry
3. Installs dependencies
4. Runs the unit tests
5. builds and pushes the image to docker hub.