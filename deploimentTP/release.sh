#!/bin/bash
set -e

echo "==> Lancement de Terraform (infrastructure)..."
cd terraform
terraform init
terraform apply -auto-approve
cd ..

echo "==> Déploiement de l’API avec Ansible..."
ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
