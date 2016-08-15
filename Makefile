certs_dir := $(CURDIR)/certs

build:
	docker build -t pgarrett/openssl .

clean:
	rm -rf ${certs_dir}; docker rm -f crt; true

run: build clean
	docker run --name crt -v ${certs_dir}:/etc/ssl/certs pgarrett/openssl

verify: run
	openssl x509 -in ${certs_dir}/public.crt -text -noout

help:
	@echo "Usage: make build|clean|run|verify"
