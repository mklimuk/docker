# CLAUDE.md - Docker Project Guide

## Build Commands
- `docker build -t golang:cross -f golang/cross.Dockerfile .` - Build cross-compilation image
- `docker build -t golang:cross-wails -f golang/cross-wails.Dockerfile .` - Build Wails cross-compilation image
- `docker build -t docker.satsoft.pl/build/golang-cross-buster:1.24 -f golang/cross-buster.Dockerfile ./golang` - Build Buster-based cross-compilation image
- `docker build -t golang:armhf -f golang/armhf.Dockerfile .` - Build armhf-specific image
- `docker build -t golang:x64 -f golang/x64.Dockerfile .` - Build x64 image

## Development Workflow
- Use Mage as the primary build tool (`mage [command]`)
- For Go cross-compilation, use the appropriate Docker container with properly set CGO flags

## Code Style Guidelines
- Follow Go standard formatting (gofmt)
- Docker best practices:
  - Minimize layers by combining related RUN commands
  - Use specific version tags for base images
  - Clean up package manager caches in the same layer
- Environment variables should be grouped by purpose
- Use proper line continuation in Dockerfiles with backslashes
- Document non-obvious configuration settings with comments

## Technology Stack
- Go (1.18 - 1.24)
- Mage build tool
- Wails framework for GUI applications
- Node.js (v20)
- Cross-compilation support (armhf)