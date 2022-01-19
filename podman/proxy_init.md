### vi /etc/yum.repos.d/epel-yum-ol7.repo
```
[ol7_epel]
name=Oracle Linux $releasever EPEL ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer_EPEL/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
```
### update repos and enable httpd
```
yum update -y
yum install -y wget openssl crypto-utils http mod_ssl vim htop atop
systemctl enable --now httpd.service
systemctl status httpd
```

### vim /etc/httpd/conf/httpd.conf
```
ServerRoot "/etc/httpd"
ServerName localhost
```


### vim /etc/httpd/conf.d/server_proxy.conf
```
Listen *:8443

<VirtualHost *:8443>
  ServerName proxy.server.com

  ErrorLog              /var/log/httpd/proxy_server.log
  CustomLog             /var/log/httpd/proxy_server_access.log combined

#  RequestHeader set X-Forwarded-Proto "http"
#  SSLProxyEngine On
#  SSLProxyVerify none
#  SSLProxyCheckPeerCN off
#  SSLProxyCheckPeerName off
#  SSLProxyCheckPeerExpire off
#  RequestHeader set X-Forwarded-Proto "http"
#  RequestHeader set X-Forwarded-For
#  RemoteIPHeader X-Forwarder-For
#  ProxyRequests off

  ProxyPreserveHost On
  ProxyPass "/" "http://server_name:8080/"
  ProxyPassReverse "/" "http://server_name:8080/"
  ProxyAddHeaders off
  RequestHeader unset X-Forwarded-For
  RequestHeader set X-Forwarded-For "http://localhost:8443"

</VirtualHost>

```

### Reload httpd:
```
  systemctl daemon-reload
  systemctl restart httpd
  systemctl status httpd.service
```