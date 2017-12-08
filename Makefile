certs_dir := $(CURDIR)/certs

build:
	docker build -t pgarrett/openssl-alpine .

push:
	docker push pgarrett/openssl-alpine

clean:
	rm -rf ${certs_dir}
	docker ps -aq | xargs --no-run-if-empty docker rm -f

run: build clean
	docker run --rm --name crt -v ${certs_dir}:/etc/ssl/certs pgarrett/openssl-alpine

verify: run
	openssl x509 -in ${certs_dir}/public.crt -text -noout

help:
	@echo "Usage: make build|push|clean|run|verify"
