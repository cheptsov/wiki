FROM golang:1.8.1
RUN go get -u -v github.com/derekparker/delve/cmd/dlv
EXPOSE 2345

RUN mkdir -p /app
ADD . /app/
WORKDIR /app
RUN go build -o main .

EXPOSE 8080
# CMD ["/app/main"]
CMD ["dlv", "--listen=0.0.0.0:2345", "--headless=true", "--log", "--api-version=2", "--backend=native", "exec", "/app/main", "--"]