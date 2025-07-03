# First Stage: Build the application
FROM golang:1.23 AS base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o /app/main .

# Second Stage: Create the final image

FROM gcr.io/distroless/base

COPY --from=base /app/main ./main
COPY --from=base /app/static ./static

EXPOSE 8080
CMD ["/main"]


