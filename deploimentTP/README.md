📝 Rapport de mise en œuvre – Pipeline CI/CD pour l’API de supervision de capteurs

🎯 Domaine fonctionnel : API de supervision de capteurs

Le projet consiste à concevoir et déployer une API capable de collecter, stocker et exposer des données issues de capteurs environnementaux (température, humidité, CO₂, etc.). Cette API est destinée à être utilisée dans un contexte IoT afin de superviser à distance l'état d'un bâtiment ou d’une zone spécifique.

☁️ Choix d’infrastructure et du provider

Provider cloud : Microsoft Azure

Infrastructure-as-Code : Terraform

Configuration serveur et déploiement : Ansible

VM Linux (Ubuntu Server 20.04)

Provisionnement de :

Resource group, VNet, Subnet, Public IP, NSG, NIC

Machine virtuelle avec clé SSH RSA

Justification :
Azure est un choix solide pour l’hébergement sécurisé d’API avec de bons outils d’intégration. Terraform et Ansible permettent d’automatiser toute la chaîne de provisionnement + configuration.

📁 Structure des dossiers

Le projet est organisé de manière modulaire :

graphql
Copier
Modifier
.
├── api/                  # Code source de l’API (Node.js ou Python)
│   ├── package.json / requirements.txt
│   └── index.js / app.py
├── ansible/
│   ├── inventory.ini     # IP ou nom DNS public de la VM
│   ├── deploy.yml        # Playbook Ansible
├── terraform/
│   ├── main.tf           # Provisionnement Azure
├── .github/
│   └── workflows/
│       └── deploy.yml    # Pipeline CI/CD
├── release.sh            # Script qui orchestre Terraform + Ansible
└── README.md
🔁 Fonctionnement du pipeline CI/CD

Outil : GitHub Actions

Déclencheur : push de tag Git (ex : v1.0.0)

Pipeline :

Checkout du dépôt

Installation de Terraform, Ansible, Python

Exécution du script release.sh :

Provisionnement ou mise à jour de l’infrastructure avec Terraform

Déploiement de l’API sur la VM avec Ansible :

Installation de Git, Node.js ou Python

Clonage du repo

Installation des dépendances

Redémarrage avec PM2 ou Gunicorn/systemd

🧱 Obstacles rencontrés et solutions

🔴 Problème :
Erreur Terraform : « SSH key non supportée : ed25519 »

✅ Solution :
Génération d’une clé RSA via ssh-keygen -t rsa -b 2048 et mise à jour dans le main.tf

🔴 Problème :
Erreur Ansible « ansible-playbook: commande non reconnue »

✅ Solution :
Installation locale d’Ansible (sudo apt install ansible) ou exécution via pipeline GitHub dans une image ubuntu

🔴 Problème :
Erreur de VM Azure : PlatformImageNotFound

✅ Solution :
Correction de l’image dans main.tf (ex: Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest)

🔴 Problème :
NSG mal configuré (erreurs 400)

✅ Solution :
Ajout explicite de source_port_range et source_address_prefix dans les règles de sécurité réseau

📸 Captures recommandées à inclure :

Terraform plan et apply (terminal)

Exécution de release.sh

Résultat du pipeline GitHub Actions

Test de l’API sur l’IP publique (curl ou navigateur)