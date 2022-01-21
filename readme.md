# how to connect to the podman service
run wsl podman service:
```
podman system service --time=0 tcp:0.0.0.0:2979
```
connect via tcp://localhost:2979 you intellij idea.


# how to connect to run clean ssp
Variables:
`hostname=ssp_clean`
`container_name=ssp_container`

```
podman run -d -it -p 9443:9443 -p 8080:8080 -p 4200:4200 --privileged --systemd=true --name $container_name -h $hostname ssp73 /usr/sbin/init
```

podman run with mounted folder:
- type: bind
read_only: false
source: C:\bundles\vodafone\deploy\
target: /u02/netcracker/ssp/deploy

- `hostname=ssp_clean`
- `container_name=ssp_container`
- `source=/mnt/c/bundles/vodafone742/deploy/`
- `target=/u02/netcracker/ssp/deploy`

```
hostname=ssp_clean
container_name=ssp_container
source=/mnt/c/bundles/vodafone742/deploy/
target=/u02/netcracker/ssp/deploy
mount=type=bind,ro=false,source=/mnt/c/bundles/vodafone742/deploy,target=/u02/netcracker/ssp/deploy
podman run -d -it -p 9443:9443 -p 8080:8080 -p 4200:4200 --privileged --systemd=true --name $container_name -h $hostname --mount=$mount ssp_clean:7.3 /usr/sbin/init 
```

final version:
```
podman run -d -it -p 9443:9443 -p 8080:8080 -p 4200:4200 --privileged --systemd=true --name ssp73 -h ssp73 --mount=type=bind,ro=false,source=/mnt/c/bundles/vodafone742/deploy,target=/u02/netcracker/ssp/deploy ssp_clean:7.3 /usr/sbin/init
```