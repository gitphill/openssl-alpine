IMAGE=pgarrett/openssl-alpine
CERTS=$(CURDIR)/certs

.PHONY: build clean run test help

build:
	docker build -t $(IMAGE) .

clean:
	rm -rf $(CERTS)

run: build clean
	docker run --rm --name crt -v $(CERTS):/etc/ssl/certs $(IMAGE)

test: run
	openssl verify -CAfile certs/ca.pem certs/root.crt certs/example.crt certs/public.crt

help:
	@echo "Usage: make build|clean|run|test"
