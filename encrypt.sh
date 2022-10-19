#!/bin/sh

echo -e "# pull unencrypted image\n"
sleep 3

if [ ! -d hello-world ]; then
    skopeo copy docker://docker.io/library/hello-world:latest oci:hello-world:latest
else
    echo "image pulled already"
fi

echo -e "\n# run skopeo to encrypt, get wrapped encryption key from a 'keyprovider' through gRPCn"
sleep 3

cat ocicrypt.conf

if [ -d hello-world-encrypted ]; then
	rm -rf hello-world-encrypted
fi

OCICRYPT_KEYPROVIDER_CONFIG=ocicrypt.conf skopeo copy --insecure-policy --encryption-key provider:attestation-agent:hello oci:hello-world oci:hello-world-encrypted
