# Confidential Containers Image Encryption Using a Keyprovider gRPC Service

This repository demonstrates how encrypt container layers with an external gRPC KeyProvider
service for Key wrapping. We use Confidential Container's `sample_keyprovider`.

[<img src="https://asciinema.org/a/g82wxCicc0WsQPcsAAPV4FDVL.svg" width="700">](https://asciinema.org/a/g82wxCicc0WsQPcsAAPV4FDVL)

## Pre-requisites

- podman/docker
- make
- grep
- git

## Setup

```
$ git clone --recurse-submodules https://github.com/mythi/coco-image-encryption-demo
$ cd coco-image-encryption-demo
```

## Start KeyProviderService

```
$ make setup
```

or alternatively, if `podman` is used:

```
$ make setup CONTAINER_ENGINE=podman
```

## Encrypt hello-world Image

```
$ make encrypt
```

or alternatively, if `podman` is used:

```
$ make encrypt CONTAINER_ENGINE=podman
```

## Check the hello-world Image

```
$ make check
```

or alternatively, if `podman` is used:

```
$ make check CONTAINER_ENGINE=podman
```

## Cleanup Environment

```
$ make stop
```

or alternatively, if `podman` is used:

```
$ make stop CONTAINER_ENGINE=podman
```

## Troubleshooting

`make setup` starts two containers: `keyprovider` and `imgencrypter`. Try `docker/podman logs`
for starters.
