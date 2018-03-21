# prometheus-docker-armv6
Prometheus docker for ARMv6

Take the latest release, like this one

https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-armv6.tar.gz

unpack and place Dockerfile inside unpacked folder.

Then build with

```sudo docker build -t local/rpi-prom .```

Then build target image with

```
FROM local/rpi-prom
COPY ./prometheus.yml /etc/prometheus/prometheus.yml
```

```sudo docker build -t local/rpi-prom .```

Run image with

```sudo docker run -p 9090:9090 --name prometheus-rpi -d local/rpi-prom-monit```

In case of modifications

```sudo docker rm -f prometheus-rpi```

```sudo docker rmi local/rpi-prom-monit```

...and start over.