vi /etc/yum.repos.d/epel-yum-ol7.repo
----------content-------------
[ol7_epel]
name=Oracle Linux $releasever EPEL ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer_EPEL/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
----------content-------------

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
Listen *:9090

<VirtualHost *:9090>
  ServerName onloading.com

  ErrorLog              /var/log/httpd/server_proxy_error.log
  CustomLog             /var/log/httpd/server_proxy-errors.log combined

  #RequestHeader set X-Forwarded-Proto "http"

  SSLProxyEngine On
  SSLProxyVerify none
  SSLProxyCheckPeerCN off
  SSLProxyCheckPeerName off
  SSLProxyCheckPeerExpire off

# redirect to the particulat host and setup x-forwarded-for header
#  ProxyPreserveHost On
#  ProxyPass "/" "http://ws-13567:8080/"
#  ProxyPassReverse "/" "http://ws-13567:8080/"
#  ProxyAddHeaders off
#  RequestHeader unset X-Forwarded-For
#  RequestHeader set X-Forwarded-For "http://localhost:8443"


  ProxyRequests On
  ProxyVia On
  <Proxy "*">
  </Proxy>

  #  ProxyPreserveHost       On
  #  ProxyPass "/" "https://:9443/"
  #  ProxyPassReverse "/" "https://10.109.8.42:9443/"

</VirtualHost>
----------content-------------