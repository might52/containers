vi /etc/yum.repos.d/epel-yum-ol7.repo
```
[ol7_epel]
name=Oracle Linux $releasever EPEL ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer_EPEL/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
```

yum install -y wget openssl crypto-utils http mod_ssl vim htop atop
systemctl enable --now httpd.service
systemctl status httpd

vim /etc/httpd/conf/httpd.conf
----------content-------------
ServerRoot "/etc/httpd"
ServerName localhost
----------content-------------


vim /etc/httpd/conf.d/server_proxy.conf
----------content-------------
  Listen *:8443

  <VirtualHost *:8443>
  ServerName onloading.com

  ErrorLog              /var/log/httpd/proxy_server.log
  CustomLog             /var/log/httpd/proxy_server_access.log combined

  #RequestHeader set X-Forwarded-Proto "http"

  SSLProxyEngine On
  SSLProxyVerify none
  SSLProxyCheckPeerCN off
  SSLProxyCheckPeerName off
  SSLProxyCheckPeerExpire off

  ProxyPreserveHost       On
  ProxyPass "/" "https://10.109.8.42:9443/"
  ProxyPassReverse "/" "https://10.109.8.42:9443/"

  </VirtualHost>
----------content-------------
#Reload httpd:
```
  systemctl daemon-reload
  systemctl restart httpd
  systemctl status httpd.service
```