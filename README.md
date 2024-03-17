# legal-term-api

An HTTP API for legal terms.

## Endpoints

* `GET /terms`: list all available terms.
* `GET /definitions?term=<term>`: get the definition of a term.

## Pre Requisites

You need to have the following installed

* docker desktop
* Terraform
* 

## To run the app locally via DockerFile

1. cd legal-term-api 
2. docker build -t casetext .
3. docker run -p 8000:8000 casetext ( use -d to run as daemon)

## For local development

1. Install [minikube](https://minikube.sigs.k8s.io/docs/start/)
2. minikube start
3. Install [Kubectl]()
4. cd legal-term-api
5. kubernetes apply -f local-manifest.yaml
6. Confirm deployment has been created : `kubectl get deployment`
7. Confirm service has been created : `kubectl get svc`
8. Run `kubectl port-forward svc/python-casetext 8000:8000` 
9. Go to http://localhost:8000/terms to access it via the browser. 

## OPTIONAL : Provision EKS cluster on AWS EKS and access the app

1. sso into your aws account.
2. cd legal-term-api/infra
3. `terraform init` 
4. `terraform plan` 
5. `terraform apply`
6. Creates a VPC with the following components : VPC, 2 subnets, A SG group that allows all traffic, a route table and an internet gateway.
7. Creates an EKS cluster with a self managed node group, a deployement and a load balancer service. 
8. Copy the `load_balancer_hostname` from the outputs of the `tf apply`.
9. Go to the browser, paste the `http://load_balancer_hostname:8000/terms` to access the API. ( Note : it may take a while to serve the page so you may have to refresh the page a couple of times.)
10. `terraform destroy` for cleanup.

## Pipeline Overview

The pipelien is built using CircleCI. It runs the following steps : 

1. Checkout code
2. Installs poetry
3. Installs dependencies
4. Runs the unit tests
5. builds and pushes the image to docker hub.