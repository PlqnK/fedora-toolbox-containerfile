#!/usr/bin/env bash

version=39

podman container stop fedora-toolbox
toolbox rm fedora-toolbox
podman image rm localhost/fedora-toolbox:${version}
podman pull registry.fedoraproject.org/fedora-toolbox:${version}
podman build -t fedora-toolbox:${version} .
toolbox create --image localhost/fedora-toolbox:${version}
