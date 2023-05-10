#!/usr/bin/env bash

podman container stop fedora-toolbox-38
toolbox rm fedora-toolbox-38
podman build -t fedora-toolbox-38 .
toolbox create --image fedora-toolbox-38
