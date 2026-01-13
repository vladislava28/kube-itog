FROM golang:1.25.4-alpine AS builder

WORKDIR /app

COPY ./cmd/root-service/ .

COPY ./go.mod .

RUN go mod tidy

RUN go build -o root-app

# STAGE 2

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/root-app .

EXPOSE 8080

CMD ["/app/root-app"]