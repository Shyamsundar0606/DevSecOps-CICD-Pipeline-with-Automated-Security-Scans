# DevSecOps CI/CD Pipeline with Automated Security Scans

*Automated Security \| CI/CD \| SAST \| DAST \| IaC Security \|
Container Scanning \| GitHub Actions*

This project implements a fully automated **DevSecOps CI pipeline** that
integrates security tools at every stage of development using **GitHub
Actions**.\
The goal is to demonstrate **Shift-Left Security** --- detecting
vulnerabilities early, automatically, and without any cloud cost.

This project is ideal for: - MSc Computer Security students\
- DevSecOps learning\
- Internship/Job portfolio\
- Demonstrating real-world CI/CD + security practices

------------------------------------------------------------------------

# 🚀 Project Features

### ✔ Dockerized Python Flask Web Application

### ✔ GitHub Actions CI Pipeline

### ✔ Automated Security Scanning

-   **Bandit** → Python SAST\
-   **pip-audit** → Dependency vulnerability scan\
-   **Trivy** → Docker image CVE scanning\
-   **Checkov** → Terraform IaC misconfiguration scanning\
-   **OWASP ZAP Baseline** → DAST (passive scan)

### ✔ Infrastructure as Code (Terraform)

-   Not deployed (to avoid AWS cost)
-   Securely scanned by Checkov in CI

Everything is done using **free tools** and **free GitHub runners**.

------------------------------------------------------------------------

# 📂 Project Structure

``` text
DevSecOps CICD Pipeline with Automated Security Scans/
│
├── app.py                     # Flask application
├── Dockerfile                 # Docker build instructions
├── requirements.txt           # Python dependencies
│
├── infra/                     # Terraform IaC (scanned only, not deployed)
│   ├── provider.tf
│   ├── network.tf
│   └── ecs.tf
│
└── .github/workflows/
    └── ci.yml                 # GitHub Actions DevSecOps pipeline
```

------------------------------------------------------------------------

# 🔄 CI/CD Pipeline Workflow (GitHub Actions)

## 1️⃣ Build Stage

-   Checks out repository\
-   Sets up Python\
-   Installs dependencies\
-   Builds Docker image

## 2️⃣ Security Stage (Shift-Left Security)

  ------------------------------------------------------------------------
  Tool        Security Type   Description
  ----------- --------------- --------------------------------------------
  Bandit      SAST            Static analysis of Python vulnerabilities

  pip-audit   Dependency Scan Finds CVEs in Python packages

  Trivy       Container Scan  Scans Docker image for vulnerabilities

  Checkov     IaC Scan        Detects AWS Terraform misconfigurations

  OWASP ZAP   DAST            Passive scan of the running web application
  ------------------------------------------------------------------------

## 3️⃣ Results

-   All logs and findings visible in GitHub Actions\
-   Pipeline always completes (non-blocking demo mode)

------------------------------------------------------------------------

# ▶️ Running the Application Locally

### 1. Build Docker image

``` bash
docker build -t devsecops-demo .
```

### 2. Run the container

``` bash
docker run -p 5000:5000 devsecops-demo
```

### 3. Test in browser

    http://localhost:5000

Health check:

    http://localhost:5000/health

------------------------------------------------------------------------

# 🧪 Running Terraform (Safe --- No AWS Billing)

Terraform is used for **IaC scanning only**, not deployment.

``` bash
cd infra
terraform init
terraform validate
```

Running `terraform plan` will show credential errors because AWS keys
were deleted --- **this is expected and safe**.

------------------------------------------------------------------------

# 🛡️ Running Checkov Locally (Optional)

If PATH isn't configured:

    "C:\\Users\\shyam\\AppData\\Local\\Packages\\PythonSoftwareFoundation.Python.3.11_qbz5n2kfra8p0\\LocalCache\\local-packages\\Python311\\Scripts\\checkov.exe" -d infra

If PATH is configured:

``` bash
checkov -d infra
```

------------------------------------------------------------------------

# 📌 Why This Project Is Valuable

This project demonstrates real DevSecOps pipeline capabilities:

-   CI/CD automation\
-   Container security\
-   SAST + DAST\
-   Infrastructure-as-Code (Terraform)\
-   Security scanning on every push\
-   GitHub Actions integration\
-   Secure coding practices\
-   Logging, alerts, artifacts

Perfect for **MSc projects** and **DevSecOps internship applications**.

------------------------------------------------------------------------

# 🧩 Future Enhancements

-   Add unit tests with pytest\
-   Add Gitleaks for secrets scanning\
-   Add SBOM generation (Syft + Grype)\
-   Add Kubernetes deployment (Minikube)\
-   Enforce security gates (fail pipeline on critical issues)

------------------------------------------------------------------------

# 👤 Author

**Shyamsundar Sasikumar**\
MSc Computer Security (Final Year)\
GitHub: https://github.com/Shyamsundar0606
