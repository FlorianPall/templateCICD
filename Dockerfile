FROM docker.io/golang:1.23.4 AS go_build
WORKDIR /backend
# Kopiere erst go.mod und go.sum
COPY backend/go.mod backend/go.sum ./
# Kopiere den restlichen Quellcode
COPY backend/ ./
# Build den Code
RUN CGO_ENABLED=0 go build -o strichliste ./cmd/strichliste/main.go

FROM gcr.io/distroless/static-debian12
COPY --from=go_build /backend/strichliste /strichliste
EXPOSE 8080
ENTRYPOINT [ "/strichliste" ]