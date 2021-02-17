# Install (Linux)

* [Install Docker](https://docs.docker.com/compose/install/) (18.06.1-ce or later)
* [Install Docker-Compose](https://docs.docker.com/install/linux/docker-ce/ubuntu/) (1.24.1 or later)
* Follow instructions in section **Manage Docker as a non-root user** from  [Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/)
* Run command `make setup-dev`
* Open [http://localhost](http://localhost) in your browser

# Usage
### How to run
For **dev** environment run command:
```bash
make up-dev
```
For **prod** environment run command:
```bash
make up-prod
```

### How to stop docker compose
For **dev** environment run command:
```bash
make down-dev
```
For **prod** environment run command:
```bash
make down-prod
```

# Troubleshooting

>Got permission denied while trying to connect to the Docker daemon socket at
>unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.40/containers/json:
>dial unix /var/run/docker.sock: connect: permission denied

Read [Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall)

>ERROR: for nginx  Cannot start service nginx: driver failed programming external connectivity
>on endpoint nginx (c241340d756024713b661b7291a50b1d44750ba071f3e9dc3e25e2efa22b1fa9):
>Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use

It says, "address already in use". This means that something on your system,
probably Skype or a web server like Apache or nginx  is already listening on port 80.

Command to see who is using port 80
```bash
netstat -tlnp | grep 80
```
The same logic for other ports (like 3306, 5432, 81)
