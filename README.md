
# ==========================================
# Wisecow DevOps One-File Setup Script
# Docker, Kubernetes, TLS, CI/CD, Health Scripts
# ==========================================

# === Step 0: Variables ===
DOCKER_USERNAME="<dockerhub-username>"
GITHUB_REPO="https://github.com/nyrahul/wisecow.git"
WORKDIR="wisecow"

# === Step 1: Clone the Repository ===
git clone $GITHUB_REPO
cd $WORKDIR


# === Step 3: Build Docker Image ===
docker build -t $DOCKER_USERNAME/wisecow:latest .

# === Step 4: Run Docker Container Locally (Optional) ===
# docker run -p 3000:3000 $DOCKER_USERNAME/wisecow:latest

# === Step 5: Push Docker Image to Docker Hub ===
docker login
docker push $DOCKER_USERNAME/wisecow:latest

# === Step 6: Kubernetes Manifests Directory ===
mkdir -p k8s


# === Step 7: Start Minikube ===
minikube start

# === Step 8: Apply Kubernetes Manifests ===
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# === Step 9: TLS Certificate ===
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=wisecow.local"

# === Step 10: Create Kubernetes TLS Secret ===
kubectl create secret tls wisecow-tls --cert=tls.crt --key=tls.key

# === Step 11: Verify Pods and Service ===
kubectl get pods
kubectl get svc


 

chmod +x scripts/system_health.sh


