build:
	docker build -t pgarrett/ssl .

push: build
	docker push pgarrett/ssl

clean:
	docker rm -f ssl; true

run: build clean
	docker run --name ssl -d \
		-v /vagrant/certs:/etc/ssl/certs/example pgarrett/ssl
