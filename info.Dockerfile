FROM golang:1.25.4-alpine AS builder

WORKDIR /app

COPY ./cmd/info-service/ .

COPY ./go.mod .

RUN go mod tidy

RUN go build -o info-app

# STAGE 2

FROM alpine:3.22

WORKDIR /app

COPY --from=builder /app/info-app .

EXPOSE 8080

CMD ["/app/info-app"]