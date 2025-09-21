# Wisecow DevOps Trainee Practical Assessment

1️⃣ Clone Repository

'git clone https://github.com/mohammed-saifuddin/wisecow-assig.git'

cd wisecow-assig

2️⃣ Docker Commands

** Build Docker image**

docker build -t <dockerhub-username>/wisecow:latest .


 ****Run Docker container locally ****
 
docker run -p 3000:4499 saifuddin337/wisecow:latest

 **Log in to Docker Hub**
 
docker login

 **Push image to Docker Hub**
 
docker push saifuddin337/wisecow:latest

3️⃣** Kubernetes & Minikube**

**Start Minikube**

minikube start

** Verify cluster**

kubectl cluster-info

kubectl get nodes

**Apply deployment and service manifests**

kubectl apply -f k8s/deployment.yaml

kubectl apply -f k8s/service.yaml

 **Check pods and services**
 
kubectl get pods

kubectl get svc

**Access NodePort service**

minikube service wisecow-service

4️⃣ TLS Setup

**Generate self-signed certificate**

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=wisecow.local"

** Create Kubernetes TLS secret**

kubectl create secret tls wisecow-tls --cert=tls.crt --key=tls.key


5️⃣ GitHub Actions CI/CD
**Add GitHub secrets in repo settings: DOCKER_USERNAME, DOCKER_PASSWORD, KUBECONFIG**

 **Push workflow file**
 
git add .github/workflows/main.yaml

git commit -m "Add CI/CD workflow"

git push origin main


GitHub Actions will automatically:

Build Docker image

Push to Docker Hub

Deploy to Kubernetes

6️⃣ System & Application Health Scripts

** Make system health script executable**

chmod +x scripts/system_health.sh

**# Run system health check**

./scripts/system_health.sh

** Run application health checker**

bash health_check.py

7️⃣ Optional: KubeArmor Policy

**# Install KubeArmor**

kubectl apply -f https://kubearmor.com/deploy/kubearmor.yaml

**# Apply zero-trust policy**

kubectl apply -f policy/policy-deny-exec.yaml

**# Test policy violations**
kubectl exec -it <wisecow-pod-name> -- /bin/bash

Run blocked commands to verify enforcement

✅ Notes

Replace <dockerhub-username> with your Docker Hub username.

Make sure GitHub secrets are correctly set before pushing workflow.

NodePort exposes your app via Minikube IP:NodePort (e.g., http://<minikube-ip>:32000).

Optional: Use TLS to access via HTTPS.
