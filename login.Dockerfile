FROM golang:1.25.4-alpine AS builder

WORKDIR /app

COPY ./cmd/login-service/ .

COPY ./go.mod .

RUN go mod tidy

RUN go build -o login-app

# STAGE 2

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/login-app .

EXPOSE 8080

CMD ["/app/login-app"]