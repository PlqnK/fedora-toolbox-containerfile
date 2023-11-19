#!/usr/bin/env bash

version=39

podman container stop fedora-toolbox-${version}
toolbox rm fedora-toolbox-${version}
podman image rm localhost/fedora-toolbox-${version}:latest
podman pull registry.fedoraproject.org/fedora-toolbox:${version}
podman build -t fedora-toolbox-${version} .
toolbox create --image fedora-toolbox-${version}
