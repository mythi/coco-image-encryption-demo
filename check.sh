#!/bin/sh

echo -e "# observe the container encryption results based on layer mediaType\n"
sleep 3

skopeo inspect --raw oci:hello-world-encrypted | jq  '.layers[].mediaType'

echo -e "\n# observe the encryption results based on layer org.opencontainers.image.enc.* annotations\n"
sleep 3

skopeo inspect --raw oci:hello-world-encrypted | jq  '.layers[].annotations' | jq 'keys'

echo -e "\n# observe the key wrapping protocol info defined by our sample_keyprovider 'keyprovider'\n"
sleep 3

skopeo inspect --raw oci:hello-world-encrypted | jq  '.layers[].annotations."org.opencontainers.image.enc.keys.provider.attestation-agent"' | tr -d \"| base64 -d | jq 'keys'
