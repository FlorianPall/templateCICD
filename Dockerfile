# Stage 1: Angular build
FROM node:22.11.0 AS angular_build
WORKDIR /frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build --prod

# Stage 2: Go build
FROM docker.io/golang:1.23.4 AS go_build
WORKDIR /backend
COPY backend/go.mod backend/go.sum ./
RUN mkdir -p ./cmd/strichliste/frontendDist
COPY --from=angular_build /frontend/dist/frontend/browser/* ./cmd/strichliste/frontendDist/
COPY backend/ ./
RUN CGO_ENABLED=0 go build -o strichliste ./cmd/strichliste/main.go

# Final stage
FROM gcr.io/distroless/static-debian12
COPY --from=go_build /backend/strichliste /strichliste
EXPOSE 8080
ENTRYPOINT [ "/strichliste" ]