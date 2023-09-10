FROM docker.io/library/golang:1.20-alpine as builder
EXPOSE 8080

RUN apk add make

WORKDIR /app
COPY . . 

RUN make

FROM docker.io/library/alpine:3.18 as runner
WORKDIR /app

COPY --from=builder /app/static/ ./static/
COPY --from=builder /app/templates/ ./templates/
COPY --from=builder /app/htmx .

CMD ["/app/htmx"]
