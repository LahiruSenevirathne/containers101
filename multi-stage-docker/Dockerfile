# Stage 1: Build
FROM golang:1.22 AS builder

WORKDIR /app
# Copy the source code
COPY . .
# Build the app
RUN CGO_ENABLED=0 GOOS=linux go build -o hello .

# Stage 2: Run
FROM alpine:latest
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/hello .

CMD ["./hello"]
