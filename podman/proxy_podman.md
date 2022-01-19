# run command -
  Fix for podman run at the end of .bashrc: 
  
  ```
  root@ws-13567:/sys/fs/cgroup# mkdir /sys/fs/cgroup/systemd
  root@ws-13567:/sys/fs/cgroup# mount -t cgroup cgroup -o none,name=systemd /sys/fs/cgroup/systemd
  ```
run command:
```
  podman run -d -it --privileged --systemd=true --network=host --name proxy_server -h proxy_server oraclelinux:7.9 /usr/sbin/init
```

// -p 8443:8443 -p 7443:7443  - could be skiped based on the --network=host

  vi /etc/yum.repos.d/epel-yum-ol7.repo
  [ol7_epel]
  name=Oracle Linux $releasever EPEL ($basearch)
  baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer_EPEL/$basearch/
  gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
  gpgcheck=1
  enabled=1

  yum update -y
  yum install -y wget openssl crypto-utils http mod_ssl vim net-tools
  systemctl enable --now httpd.service
  systemctl status httpd
  vim /etc/httpd/conf/httpd.conf
  ServerName localhost
  ---------
  cat /etc/resolv.conf
  ---------
  vim /etc/httpd/conf.d/proxy_server.conf

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

  systemctl daemon-reload
  systemctl restart httpd
  systemctl status httpd.service

