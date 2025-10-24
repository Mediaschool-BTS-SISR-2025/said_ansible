# Template Ansible pour BTS SIO

Ce projet est un template Ansible destiné aux étudiants de BTS SIO pour automatiser le déploiement et la configuration de serveurs de développement. Il permet de mettre en place rapidement un environnement complet incluant des utilisateurs, Docker, un pare-feu et divers outils.

## Prérequis

- Ansible 2.9+ installé sur votre machine
- Accès SSH au serveur cible
- Connaissance de base de YAML et des commandes Linux

## Structure du projet

```
.
├── dev-server-setup.yml    # Playbook principal
├── inventory               # Inventaire des serveurs
├── group_vars/             # Variables globales
│   └── all.yml
└── roles/                  # Rôles Ansible
    ├── common/             # Installation des paquets de base
    ├── docker/             # Installation et configuration de Docker
    ├── firewall/           # Configuration du pare-feu
    ├── tools/              # Outils supplémentaires (Traefik, etc.)
    └── users/              # Gestion des utilisateurs
```

## Configuration

### 1. Inventaire

Modifiez le fichier `inventory` pour spécifier vos serveurs cibles :

```ini
[dev_server]
mon_serveur ansible_user=mon_utilisateur ansible_host=192.168.1.x ssh_private_key_file=/chemin/vers/cle_privee
```

### 2. Utilisateurs

Pour ajouter ou modifier des utilisateurs, éditez le fichier CSV dans `roles/users/files/users.csv` avec le format suivant :

```csv
username,comment,groups,password,shell
utilisateur1,"Nom Complet",sisr docker,motdepasse,/bin/zsh
utilisateur2,"Autre Utilisateur",slam,motdepasse,/bin/zsh
```

Ajoutez les clés publiques SSH dans `roles/users/files/keys/` avec le format `nom_utilisateur.pub`.

### 3. Variables globales

Modifiez `group_vars/all.yml` pour définir des variables globales si nécessaire.

## Rôles disponibles

### Common

Installe les paquets essentiels et configure l'environnement de base :
- Mise à jour du système
- Installation des outils essentiels (git, vim, sudo, etc.)
- Configuration de zsh comme shell par défaut
- Création des groupes SISR et SLAM

### Docker

Configure Docker et Docker Compose :
- Installation de Docker Engine
- Installation de Docker Compose
- Configuration pour démarrer au boot
- Création du groupe docker

### Utilisateurs

Gère les utilisateurs et leur environnement :
- Création des utilisateurs à partir du fichier CSV
- Configuration des clés SSH
- Installation et configuration d'Oh My Zsh avec Powerlevel10K
- Attribution des groupes (sisr, slam, docker)

### Pare-feu

Configure iptables pour sécuriser le serveur :
- Autorise SSH (port 22)
- Autorise HTTP/HTTPS (ports 80/443)
- Préserve les règles Docker
- Politique par défaut restrictive

### Tools

Installe et configure des outils supplémentaires :
- Configuration de Traefik comme reverse proxy
- Gestion des certificats SSL avec Let's Encrypt

## Utilisation

### Étape 1 : Clonez ce dépôt

```bash
git clone https://url-du-depot/ansible-template.git
cd ansible-template
```

### Étape 2 : Adaptez la configuration

1. Modifiez le fichier `inventory` avec vos serveurs
2. Ajustez les utilisateurs dans `roles/users/files/users.csv`
3. Placez les clés SSH dans `roles/users/files/keys/`

### Étape 3 : Exécutez le playbook

```bash
ansible-playbook -i inventory dev-server-setup.yml
```

Pour exécuter seulement certains rôles, utilisez des tags :

```bash
ansible-playbook -i inventory dev-server-setup.yml --tags "users,docker"
```

## Personnalisation pour vos projets

### Ajouter un nouveau rôle

1. Créez le répertoire du rôle avec la structure suivante :

```
roles/
└── mon_role/
    ├── tasks/
    │   └── main.yml
    ├── handlers/
    │   └── main.yml
    ├── templates/
    │   └── ...
    └── files/
        └── ...
```

2. Ajoutez votre rôle au playbook principal dans `dev-server-setup.yml` :

```yaml
roles:
  - common
  - docker
  - users
  - firewall
  - tools
  - mon_role
```

### Ajouter des services Docker

1. Modifiez ou créez votre fichier `docker-compose.yml` dans `roles/tools/docker/`
2. Adaptez les configurations Traefik dans `roles/tools/docker/systeme/traefik_data/configurations/`

## Bonnes pratiques pour les étudiants BTS SIO

### SISR

- Utilisez ce template pour déployer rapidement des environnements de test identiques
- Personnalisez le pare-feu selon vos besoins de sécurité
- Créez des rôles supplémentaires pour installer des services réseau spécifiques

### SLAM

- Ajoutez des rôles pour déployer vos environnements de développement (PHP, Node.js, etc.)
- Modifiez les configurations Docker pour vos applications
- Utilisez les variables Ansible pour personnaliser vos déploiements

## Dépannage

### Problème d'accès SSH

Vérifiez que :
- La clé SSH est correctement configurée dans le fichier `inventory`
- L'utilisateur a les droits sudo sur le serveur cible

### Erreurs Docker

Si Docker ne démarre pas correctement :
```bash
systemctl status docker
```

### Problèmes de pare-feu

Pour vérifier les règles du pare-feu :
```bash
sudo iptables -L -v
```

---

Ce template est conçu pour être un point de départ pour vos projets. N'hésitez pas à le personnaliser selon vos besoins spécifiques.
