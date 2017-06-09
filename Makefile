init:
	go get -u -v github.com/derekparker/delve/cmd/dlv

build:
	go build -i -o main -gcflags "-N -l" main.go

debug: init build
	dlv --listen=localhost:2345 --headless=true --log --api-version=2 --backend=native exec ./main --

image:
	docker build -t wiki .

deploy: image
	docker run --rm --name=wiki -p 8080:8080 -p 2345:2345 --security-opt=seccomp:unconfined --privileged wiki