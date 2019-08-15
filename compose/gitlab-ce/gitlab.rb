# SMTP
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.exmail.qq.com"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "auto@nordons.com"
gitlab_rails['smtp_password'] = "ZannjFGBmRsCbovV"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = true
gitlab_rails['gitlab_email_from'] = 'auto@nordons.com'
gitlab_rails['gitlab_email_enabled'] = true

# IMAP
gitlab_rails['incoming_email_enabled'] = true
gitlab_rails['incoming_email_address'] = "auto@nordons.com"
gitlab_rails['incoming_email_email'] = "incoming"
gitlab_rails['incoming_email_password'] = "ZannjFGBmRsCbovV"
gitlab_rails['incoming_email_host'] = "imap.exmail.qq.com"
gitlab_rails['incoming_email_port'] = 993
gitlab_rails['incoming_email_ssl'] = true
gitlab_rails['incoming_email_start_tls'] = false
gitlab_rails['incoming_email_mailbox_name'] = "inbox"
gitlab_rails['incoming_email_idle_timeout'] = 60

# Nginx
nginx['enable'] = true
external_url 'https://git.nordons.com'
nginx['ssl_certificate'] = '/etc/gitlab/certs/gitlab.pem'
nginx['ssl_certificate_key'] = '/etc/gitlab/certs/gitlab.key'
nginx['redirect_http_to_https'] = true

# Gitpage
pages_external_url "https://page.nordons.com"
gitlab_pages['enable'] = true
pages_nginx['redirect_http_to_https'] = true
pages_nginx['ssl_certificate'] = "/etc/gitlab/certs/gitpage.pem"
pages_nginx['ssl_certificate_key'] = "/etc/gitlab/certs/gitpage.key"
gitlab_pages['access_control'] = true

#  openldap 不成功
# gitlab_rails['ldap_enabled'] = true
# gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
#    main: # 'main' is the GitLab 'provider ID' of this LDAP server
#      label: 'Nordon'
#      host: '47.92.70.244'
#      port: 8389
#      uid: 'sAMAccountName'
#      bind_dn: 'cn=admin,dc=nordons,dc=com'
#      method: 'plain' # "tls" or "ssl" or "plain"
#      password: 'Nor08don10'
#      active_directory: true
#      allow_username_or_email_login: false
#      lowercase_usernames: false
#      block_auto_created_users: false
#      base: 'ou=user,dc=nordons,dc=com'
#      user_filter: ''
#      attributes:
#       username: ['uid']
#       email:    ['email']
#       name:       'displayName'
#       first_name: 'givenName'
#       last_name:  'sn'
# EOS
