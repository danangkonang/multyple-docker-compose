FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o heloword main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/heloword /app/heloword
EXPOSE 3000
CMD ["/app/heloword"]