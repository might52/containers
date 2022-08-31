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
podman run -d -it -p 9443:9443 -p 8080:8080 -p 18080:18080 -p 4200:4200 --privileged --systemd=true --name $container_name -h $hostname ssp73 /usr/sbin/init
```

podman run with mounted folder:
- `hostname=ssp_clean`
- `container_name=ssp_container`
- `source=/mnt/c/bundles/vodafone742/deploy/`
- `target=/u02/netcracker/ssp/deploy`
- `mount=type=bind,rw=true,source=/mnt/c/bundles/vodafone742/deploy,target=/u02/netcracker/ssp/deploy`
```
podman run -d -it -p 9443:9443 -p 18080:18080 -p 8080:8080 -p 4200:4200 --privileged --systemd=true --name $container_name -h $hostname --mount=$mount ssp_clean:7.3 /usr/sbin/init 
```

final version:
```
podman run -d -it -p 9443:9443 -p 18080:18080 -p 8080:8080 -p 4200:4200 -p 22:22 --privileged --systemd=true --name ssp73 -h ssp73 --mount=type=bind,rw=true,source=/mnt/c/bundles/vodafone742/deploy,target=/u02/netcracker/ssp/deploy ssp_clean:7.3 /usr/sbin/init
```

```
podman run -d -it -p 9443:9443 -p 18080:18080 -p 8080:8080 -p 4200:4200 -p 22:22 --privileged --systemd=true --name ssp74 -h ssp74 --mount=type=bind,rw=true,source=/mnt/c/bundles/vodafone742/deploy,target=/u02/netcracker/ssp/deploy ssp_clean:7.4 /usr/sbin/init
```

Actual using:
```
run -d -it -p 8443:8443 -p 9443:9443 -p 18080:18080 -p 8080:8080 -p 4200:4200 -p 22:22 --privileged --systemd=true --name ssp74_clean_ph3 -h ssp74_clean_ph3 --mount=type=bind,rw=true,source=/mnt/c/bundles/vodafone_ph3/deploy,target=/u02/netcracker/ssp/deploy ssp_clean:7.4_ph3 /usr/sbin/init
```

Import command:
```
import /mnt/c/repos/svn/vfhu/ssp_bundles/docker_export/ssp_clean_tmc_pg_ph3_lf74.tar.gz ssp_ph3_pg_clean:7.4
```

Export command:

```
export 2622c94b0a5e > /mnt/c/repos/svn/vfhu/ssp_bundles/docker_export/ssp_clean_tomcat_ph3_lf74_trunk_35.tar.gz
```

CLI connection:

```
exec -it e7afb27b25fc /usr/bin/bash
```
