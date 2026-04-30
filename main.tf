name: "Terraform-CI"

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:
  terraform:
    name: "Terraform Deploy"
    runs-on: ubuntu-latest

    steps:
      # 1. Checkout l-code dyalk mn GitHub
      - name: Checkout Code
        uses: actions/checkout@v4

      # 2. Azure CLI Login (Tariqa li kakhdem f Sandboxes)
      # Khass t-koun m3mmer AZURE_USER_NAME o AZURE_PASSWORD f l-Secrets
      - name: Azure CLI Login
        run: |
          az login -u "${{ secrets.AZURE_USER_NAME }}" -p "${{ secrets.AZURE_PASSWORD }}" --tenant "${{ secrets.AZURE_TENANT_ID }}"
          az account set --subscription "${{ secrets.AZURE_SUBSCRIPTION_ID }}"

      # 3. Setup Terraform wast l-Runner
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      # 4. Security Scan b Checkov (Shift Left Security)
      # Ghadi i-detecti l-port 22 m7lou7 li derti f main.tf
      - name: Checkov Scan
        uses: bridgecrewio/checkov-action@master
        with:
          directory: .
          framework: terraform
          soft_fail: true # Khllih true ila bghiti l-Plan i-douz wakha kyn risk

      # 5. Terraform Init
      - name: Terraform Init
        run: terraform init
        env:
          ARM_USE_CLI: true # Darouri bach Terraform i-st3mel l-context d az login

      # 6. Terraform Plan
      - name: Terraform Plan
        run: terraform plan
        env:
          ARM_USE_CLI: true