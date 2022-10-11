#!/bin/sh

echo -e "\n==> pull unencrypted image <==\n"
sleep 3

if [ ! -d hello-world ]; then
    skopeo copy docker://docker.io/library/hello-world:latest oci:hello-world:latest
else
    echo "image pulled already" 
fi

echo -e "\n==> run skopeo to encrypt, get wrapped encryption key from a 'keyprovider' through gRPC <==\n"
sleep 3

if [ ! -d hello-world-encrypted ]; then
    OCICRYPT_KEYPROVIDER_CONFIG=ocicrypt.conf skopeo copy --insecure-policy --encryption-key provider:attestation-agent:hello oci:hello-world oci:hello-world-encrypted
else
    echo "image encrypted already" 
fi

echo -e "\n==> observe the container encryption results based on layer mediaType <==\n"
sleep 3

skopeo inspect --raw oci:hello-world-encrypted | jq  '.layers[].mediaType'

echo -e "\n==> observe the encryption results based on layer org.opencontainers.image.enc.* annotations <==\n"
sleep 3

skopeo inspect --raw oci:hello-world-encrypted | jq  '.layers[].annotations'

echo -e "\n==> observe the key wrapping info defined by our sample_keyprovider <==\n"
sleep 3

skopeo inspect --raw oci:hello-world-encrypted | jq  '.layers[].annotations."org.opencontainers.image.enc.keys.provider.attestation-agent"' | tr -d \"| base64 -d | jq
