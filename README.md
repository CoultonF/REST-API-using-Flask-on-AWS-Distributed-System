# REST API using Flask on Minikube or AWS Distributed Microservices Architecture and DynamoDB - Load Tested using Gatling.IO with Simulated Failures

![Alt text](docs/stats.png?raw=true "Gatling.IO Runtime Statistics")

    .
    ├── API                         # Communicate with Cluster
    |   ├── Gatling                 # Gatling Code to Stress Test Cluster or Verify All API Test Cases
    |   ├── api.mak                 # Basic Running CURLs for Targeted Testing
    |   ├── gatling.mak             # Start script for Gatling Load Testing
    |   └── api-proxies.mak         # Basic Running CURLs for Gatling Recorder
    |
    ├── IaC                         # Managing Cluster
    |   ├── eks                     # EKS Cluster
    |   ├── mk                      # Minikube Cluster
    |   ├── docker.mak              # Minikube/EKS Docker Containers
    |   ├── dynamo.mak              # AWS DynamoDB
    |   └── k8s.mak                 # Minikube/EKS Kubernetes Cluster
    |
    ├── code                        # REST API, Cluster, and Docker Build Code
    |   ├── cart                    # Cart REST API
    |   ├── customer                # Customer REST API
    |   ├── db                      # DB REST API
    |   ├── history                 # History REST API
    |   ├── misc                    # Cluster, Gateway, and Database Configuration 
    |   ├── returns                 # Returns REST API
    |   └── warehouse               # Warehouse REST API
    |
    └── docs                        # Additional Documentation
        └── PDF                     # Gatling Stats with Failure Testing

    
## Project Startup and Shutdown

Ensure below project requirements are met, then run the makefiles according to desired setup
```
- make -f IaC/mk/main.mak               #(Windows/MAC)
- make -f IaC/mk/main.mak start-ubuntu  #(Ubuntu)
- make -f IaC/eks/main.mk               #(AWS)
```
Complete deletion of build environment using
```
- make -f IaC/mk/main.mak stop          #(Windows/MAC/Ubuntu)
- make -f IaC/eks/main.mk stop          #(AWS)
```
 
## Project Requirements

Project requires yq and jq to be installed on shell. <br>
https://github.com/mikefarah/yq <br>
https://stedolan.github.io/jq/download/ <br>
Maven <br> 
https://maven.apache.org/ <br>
Java 1.8 SDK <br>
https://www.oracle.com/ca-en/java/technologies/javase/javase-jdk8-downloads.html <br>
AWS Credentials and Configuration Setup <br>
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html <br>
AWS CLI <br>
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html <br>
MetalLB for Ubuntu OS <br>
https://metallb.universe.tf/ <br>
Docker<br>
https://www.docker.com/ <br>
Istio <br>
https://istio.io/latest/docs/ops/diagnostic-tools/istioctl/ <br>
Helm <br>
https://helm.sh/docs/intro/install/ <br>
Kubernetes and EKSCTL <br>
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html <br>
