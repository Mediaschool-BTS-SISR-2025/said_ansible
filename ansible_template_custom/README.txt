# Portainer-only add-on (deploy + LDAP API config)

This add-on assumes Docker is already installed.
- Role `portainer`      : deploys Portainer CE (9000/9443)
- Role `portainer_api`  : enables LDAP (StartTLS) and maps LDAP groups to teams

Defaults are fixed to your environment:
- Portainer: https://10.0.108.132:9443 (admin/admin1)
- LDAP (StartTLS): 10.0.108.132:389, bind cn=admin,dc=iris,dc=local, password admin1
- Groups -> Teams: Admins, SISR, SLAM

Usage:
  ansible-galaxy collection install -r requirements.yml
  # In your playbook, include:
  # - portainer
  # - portainer_api
