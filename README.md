# FT_SERVICES

It is a project of the school 42 Paris, it aims to make discover Kubernetes.

## Usage

To launch minikube, build all Docker images and apply them to Kubernetes just do :

```
./setup.sh
```

You can use the `--mkcert` argument to install and create certificates coming from mkcert and thus being signed on your local machine.

To clean everything (minikube, logs, certificates, etc.) you can use the command :

```
./setup.sh clean
```

## Description

This project uses MetalLB as LoadBalancer in Layer 2 mode.

##### Containers created

- nginx
- wordpress
- mysql
- phpmyadmin
- influxdb
- grafana
- ftps
- telegraf

##### Description of the containers

1. nginx
	- Create a web server based on nginx
	- Listen on port 80, 443, and 22
	- Uses https with 301 redirection from http to https
	- IP/wordpress is a 307 redirection to the IP:PORT of the wordpress container.
	- IP/phpmyadmin is a reverse proxy to IP:PORT of the phpmyadmin container.
	- Contains a ssh server
2. wordpress
	- Wordpress container using its own nginx server
	- Listen on port 5050
	- Connects to the MySQL container via Kubernetes with a ClusterIP
3. mysql
	- Mysql server with a persistant volume
4. phpmyadmin
	- PhpMyAdmin container using its own nginx server
	- Listen on port 5000
	- Connects to the MySQL container via Kubernetes with a ClusterIP
5. influxdb
	- influxdb server with a persistant volume
6. grafana
	- Grafana plateform listen on port 3000
	- Grafana monitors all containers
	- Connection with influxdb via ClusterIP
7. ftps
	- I know, a container just for ftp, without shared volume or persistent storage, it's useless or even stupid.
	- Listen on port 21
8. telegraf
	- Used to monitor all containers
	- Mounts the docker socket in the telegraf container for information access
