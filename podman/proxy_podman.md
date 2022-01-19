###Fix for podman run at the end of .bashrc:
  ```
  root@ws-13567:/sys/fs/cgroup# mkdir /sys/fs/cgroup/systemd
  root@ws-13567:/sys/fs/cgroup# mount -t cgroup cgroup -o none,name=systemd /sys/fs/cgroup/systemd
  # can be used to get ip from wsl2 machine cat /etc/resolv.conf
  ```
### run command:
```
  podman run -d -it --privileged --systemd=true --network=host --name proxy_server -h proxy_server oraclelinux:7.9 /usr/sbin/init
  // -p 8443:8443 -p 7443:7443  - could be skiped in case of --network=host
```
### add repo
```
  vi /etc/yum.repos.d/epel-yum-ol7.repo
  [ol7_epel]
  name=Oracle Linux $releasever EPEL ($basearch)
  baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer_EPEL/$basearch/
  gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
  gpgcheck=1
  enabled=1
```
### update and install apps
```
  yum update -y
  yum install -y wget openssl crypto-utils http mod_ssl vim net-tools
```

### startup httpd
```
  systemctl enable --now httpd.service
  systemctl status httpd
```
### configure httpd
```
  vim /etc/httpd/conf/httpd.conf
```
#### add after `ServerRoot "/etc/httpd"`
```
  ServerName localhost  
```
### configure proxy server
```
  vim /etc/httpd/conf.d/proxy_server.conf
```
#### add content to file
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
### Restart httpd
  systemctl daemon-reload
  systemctl restart httpd
  systemctl status httpd.service

## ad the end we will have available proxy by http://localhost:8443 via http://server_name:8080 with X-Forwarded-For header.