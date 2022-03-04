# Docker without Desktop in WSL2

$ sudo apt-get remove docker docker-engine docker.io containerd runc
$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

$ echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" |
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
    sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

$ sudo apt-get update

$ sudo apt-get install docker-ce docker-ce-cli containerd.io

$ sudo groupadd docker

$ sudo usermod -aG docker $USER

## Windows 10
Dans ~/.profile

if service docker status 2>&1 | grep -q "is not running"; then
    wsl.exe -d "${WSL_DISTRO_NAME}" -u root -e /usr/sbin/service docker start >/dev/null 2>&1
fi

## Windows 11
Dans /etc/wsl.conf

[boot]
command = "service docker start"

# Docker-compose

$ compose_version=$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/docker/compose/releases/latest | xargs basename)

$ curl -fL --create-dirs -o ~/.docker/cli-plugins/docker-compose \
    "https://github.com/docker/compose/releases/download/${compose_version}/docker-compose-linux-$(uname -m)"

$ chmod +x ~/.docker/cli-plugins/docker-compose

$ switch_version=$(curl -fsSL -o /dev/null -w "%{url_effective}" https://github.com/docker/compose-switch/releases/latest | xargs basename)

$ sudo curl -fL -o /usr/local/bin/docker-compose \
    "https://github.com/docker/compose-switch/releases/download/${switch_version}/docker-compose-linux-$(dpkg --print-architecture)"

$ sudo chmod +x /usr/local/bin/docker-compose
