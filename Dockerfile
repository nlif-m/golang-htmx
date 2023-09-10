FROM docker.io/library/golang:1.20-alpine as builder
EXPOSE 8080

RUN apk add make

WORKDIR /app
COPY . . 

RUN go fmt ./... && go vet ./... && go build ./...

CMD ["/app/htmx"]
