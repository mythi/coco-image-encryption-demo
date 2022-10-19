CONTAINER_ENGINE ?= "docker"

setup:
	@$(CONTAINER_ENGINE) run --rm --detach --name keyprovider --network host -v $(PWD)/attestation-agent/:/demo --workdir /demo/sample_keyprovider docker.io/rust:slim-buster sh -c "rustup component add rustfmt && cargo clean && RUST_LOG=sample_keyprovider cargo run --features sample_enc --release -- --keyprovider_sock 127.0.0.1:50000"
	@$(CONTAINER_ENGINE) run --rm --detach --name imgencrypter --network host -v $(PWD):/demo --entrypoint /demo/setup.sh quay.io/centos/centos:stream9
	@exit=1; echo -n "waiting for KeyProviderService gRPC"; while [ 0 != $$exit ]; do \
		sleep 30; \
		$(CONTAINER_ENGINE) logs --details --tail 1 keyprovider 2>&1|grep -q "listening to socket addr"; \
		exit=$$?; \
		echo -n "."; \
	done; echo "ready."

encrypt:
	@$(CONTAINER_ENGINE) exec -it --workdir /demo imgencrypter /demo/encrypt.sh

check:
	@$(CONTAINER_ENGINE) exec -it --workdir /demo imgencrypter /demo/check.sh

stop:
	@$(CONTAINER_ENGINE) stop keyprovider imgencrypter

.PHONY: setup encrypt check stop
