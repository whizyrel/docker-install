# Docker Installation Shell Script

This repository contains the following files

- An [Install](./install.sh) Script and
- An [Uninstall](./uninstall.sh) Script
- A Docker Compose [Install](./compose.sh) Script
- A Docker Compose [Uninstall](./compose-uninstall.sh) Script

Feel free to look in the scripts

## Install

Make scripts executable with

```bash
chmod +x install.sh
chmod +x uninstall.sh
chmod +x compose.sh
chmod +x compose-uninstall.sh
```

Then run the desired script

```bash
# This
./install.sh ...
# or that
./uninstall.sh ...
./compose.sh ...
./compose-uninstall.sh ...
```

The install script has the following arguments:

- `--password`: Sudo user password  Ex. `--password="$PASSWORD"`
- `--remove`: Whether to remove the existing Docker installation Ex. `--remove=true`
- `--test`: Whether to test Docker installation with runnning the hello-world docker container Ex. `--test=true`

It is worthy of note that the install script uses the uninstall script to so another argument

- `--clearfile`: Whether to remove the docker installation files in `/var/lib/docker` and `/var/lib/containerd` files Ex. `--clearfile=true`

The uninstall script has the following arguments:

- `--password`: Sudo user password same as in install script above. Ex. `--password="$PASSWORD"`
- `--remove`: Whether to remove the existing Docker libraries Ex. `--remove=true`

### Compose Install & Uninstall options

- `--password`: Sudo user password same as in install script above. Ex. `--password="$PASSWORD"
- `--user`: install docker compose for current user or not. Ex. `--user=true`
