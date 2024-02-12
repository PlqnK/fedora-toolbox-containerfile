FROM registry.fedoraproject.org/fedora-toolbox:39

COPY usr/local/bin/ /usr/local/bin/

RUN chmod +x /usr/local/bin/host-runner && \
    for executable in podman vagrant virsh virt-install; do \
      ln -s /usr/local/bin/host-runner /usr/local/bin/$executable; \
    done

COPY etc/yum.repos.d/ /etc/yum.repos.d/

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc

RUN dnf copr enable -y atim/starship

RUN dnf upgrade -y && \
    dnf install -y \
    openssh rsync curl wget \
    zsh zsh-autosuggestions zsh-syntax-highlighting fzf tmux starship git \
    levien-inconsolata-fonts \
    vim code \
    make butane \
    ansible python3-ansible-lint python3-passlib python3-netaddr python3-jmespath \
    ShellCheck \
    jq bat ripgrep \
    iputils tcpdump netcat ndisc6 bind-utils nmap whois ipcalc \
    p7zip zip unzip unrar \
    pandoc perl-Image-ExifTool ImageMagick \
    yt-dlp

RUN wget -O bitwarden-cli.zip "https://vault.bitwarden.com/download/?app=cli&platform=linux" && \
    unzip bitwarden-cli.zip && \
    mv bw /usr/local/bin/bw && \
    chown root:root /usr/local/bin/bw && \
    chmod +x /usr/local/bin/bw && \
    rm -f bitwarden-cli.zip

RUN release=$(curl -s "https://api.github.com/repos/twpayne/chezmoi/releases/latest" | jq -r '.tag_name') && \
    dnf install -y "https://github.com/twpayne/chezmoi/releases/download/${release}/chezmoi-${release//v}-x86_64.rpm"

CMD /usr/bin/bash
