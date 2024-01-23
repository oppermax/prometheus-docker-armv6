# prometheus-docker-armv6
Prometheus on Docker for ArmV6 devices like the Raspberry Pi Zero

## Updating the image 

Check for the latest version of prometheus in their GitHub releases and adjust the version in the Makefile:

```Makefile
VERSION = 2.30.3
```

Then run:

```shell
make docker-push
```

## Using the image

### Pulling the image

```shell
docker pull oppermax/prometheus-docker-armv6:latest
```

### Using docker-compose (recommended)


On your device, create a directory:

```shell
mkdir prometheus-docker
```

Create another directory for the prometheus configuration and data:

```shell
mkdir prometheus
```

Create a prometheus.yml file in the prometheus directory:

```shell
touch prometheus/prometheus.yml
```

Copy the basic config and adjust it to your needs:

```yaml
# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
```

Copy the docker-compose.yml file to your ArmV6 device and run:

```shell
docker-compose up -d
```

Check your prometheus instance at http://HOST_IP:9090
