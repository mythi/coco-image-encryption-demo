# Confidential Containers Image Encryption Using a Keyprovider gRPC Service

This repository demonstrates how encrypt container layers with an external gRPC KeyProvider
service for Key wrapping. We use Confidential Container's `sample_keyprovider`.

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
$ make run
```

or alternatively, if `podman` is used:

```
$ make run CONTAINER_ENGINE=podman
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
