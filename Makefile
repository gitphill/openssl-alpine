build:
	docker build -t pgarrett/openssl .

push: build
	docker push pgarrett/openssl

clean:
	docker rm -f ssl; true

run: build clean
	docker run --name ssl -d \
		-v /vagrant/certs:/etc/ssl/certs/example pgarrett/openssl
