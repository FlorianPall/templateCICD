FROM docker.io/golang:1.23.4 AS go_build
WORKDIR /backend
COPY backend/go.mod backend/go.sum ./
COPY backend/ ./
RUN CGO_ENABLED=0 go build -o strichliste ./cmd/strichliste/main.go

FROM gcr.io/distroless/static-debian12
COPY --from=go_build /backend/strichliste /strichliste
EXPOSE 8080
ENTRYPOINT [ "/strichliste" ]