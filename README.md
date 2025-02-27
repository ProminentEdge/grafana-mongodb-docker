# Retrieve latest SSL certificates
```
# copy from s3
aws s3 cp s3://pe-piper/lego/certificates/auto.prominentedge.com.crt ./ssl/auto.prominentedge.com.fullchain.pem
aws s3 cp s3://pe-piper/lego/certificates/auto.prominentedge.com.key ./ssl/auto.prominentedge.com.privkey.pem
aws s3 cp s3://pe-piper/lego/certificates/autotest.prominentedge.com.crt ./ssl/autotest.prominentedge.com.fullchain.pem
aws s3 cp s3://pe-piper/lego/certificates/autotest.prominentedge.com.key ./ssl/autotest.prominentedge.com.privkey.pem

# name properly for grafana
cp ./ssl/auto.prominentedge.com.fullchain.pem ./ssl/grafana.crt
cp ./ssl/auto.prominentedge.com.privkey.pem ./ssl/grafana.key
```

# Grafana MongoDB datasource Docker container

[![Docker Hub](https://img.shields.io/docker/v/ajeje93/grafana-mongodb?label=Docker%20Hub&sort=date)](https://hub.docker.com/r/ajeje93/grafana-mongodb)

[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fajeje93%2Fgrafana-mongodb-docker%2Fbadge%3Fref%3Dmaster&style=flat)](https://actions-badge.atrox.dev/ajeje93/grafana-mongodb-docker/goto?ref=master)

## Credits

Thank to JamesOsgood for creating the plugin <https://github.com/JamesOsgood/mongodb-grafana>.

Thank to SiemaApplications for upgrading and maintaining the plugin <https://github.com/SiemaApplications-attic/mongodb-grafana>. Refer to their repository for the plugin usage.

## Usage

Just run `docker-compose up -d` to start the container.
