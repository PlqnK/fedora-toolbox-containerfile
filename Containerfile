FROM registry.fedoraproject.org/fedora-toolbox:38

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
    fish fzf tmux starship git \
    vim code \
    ansible python-passlib python-netaddr \
    ShellCheck \
    bat ripgrep \
    iputils tcpdump netcat ndisc6 bind-utils nmap whois ipcalc \
    p7zip zip unzip unrar \
    pandoc perl-Image-ExifTool \
    yt-dlp && \
    dnf clean all

CMD /usr/bin/bash
