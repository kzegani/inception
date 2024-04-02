# inception

# installation
To install Docker and Docker Compose on Debian, you can follow these steps:

## Install Docker
1. Update apt package index:
```bash
sudo apt update
```

2. Install dependencies to allow apt to use a repository over HTTPS:
```bash
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

3. Add Docker's official GPG key using the recommended method:
  - Download the Docker GPG key:
  ```bash
  curl -fsSL https://download.docker.com/linux/debian/gpg -o docker.gpg
  ```
  - Add the GPG key to your system's trusted keys:
  ```bash
  sudo mkdir -p /usr/share/keyrings
  ```
  ```bash
  sudo mv docker.gpg /usr/share/keyrings/docker-archive-keyring.gpg
  ```

4. Add the Docker repository to your system:
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

5. Update apt package index again:
```bash
sudo apt update
```

6. Install Docker Engine:
```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

7. Verify that Docker Engine is installed correctly by running the following command:
```bash
sudo docker --version
```

- You should see output similar to this:
```bash
Docker version xx.yy.zz, build abcdefg
```

8. Start Docker service:
```bash
sudo systemctl start docker
```
Docker should now be installed and running on your Debian system.

## Install Docker Compose

1. Download the latest stable release of Docker Compose:
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

2. Apply executable permissions to the Docker Compose binary:
```bash
sudo chmod +x /usr/local/bin/docker-compose
```

3. Verify that Docker Compose is installed correctly:
```bash
docker-compose --version
```
- You should see output similar to this:
```bash
docker-compose version xx.yy.zz, build abcdefg
```

Docker Compose is now installed on your Debian system.
