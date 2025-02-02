### URL externe
external_url 'http://gitlab.example.com'

### Fuseau horaire
gitlab_rails['time_zone'] = 'Europe/Paris'

### Mot de passe root initial (facultatif, mais pratique)
gitlab_rails['initial_root_password'] = 'CHANGER_MOI'

### Configuration SMTP de base (exemple avec un serveur smtp.example.com)
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = 'smtp.example.com'
gitlab_rails['smtp_port'] = 587
gitlab_rails['smtp_user_name'] = 'gitlab@example.com'
gitlab_rails['smtp_password'] = 'SUPER_SECRET'
gitlab_rails['smtp_domain'] = 'example.com'
gitlab_rails['smtp_authentication'] = 'login'
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false  # true si nécessaire, en fonction du provider

# Éventuellement, configurer l’email « from » par défaut:
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = 'gitlab@example.com'
gitlab_rails['gitlab_email_reply_to'] = 'gitlab@example.com'

### Configuration de backup
# Où GitLab va stocker ses backups
gitlab_rails['backup_path'] = '/var/opt/gitlab/backups'
# Permissions de l’archive de backup
gitlab_rails['backup_archive_permissions'] = 0644
# Conserver les backups pendant 7 jours (en secondes : 7 * 24 * 3600)
gitlab_rails['backup_keep_time'] = 604800

### Exemple de configuration du nombre de workers Puma
# (Utile pour un serveur avec un peu de RAM)
puma['worker_processes'] = 2

### (Autres configurations possibles)
# - LDAP (gitlab_rails['ldap_enabled'] = true, etc.)
# - Let's Encrypt si vous activez HTTPS sur external_url
# - GitLab Registry, etc.
