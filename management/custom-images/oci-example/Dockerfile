## NOTE: This image must be built for linux/amd64 use --platform linux/amd64 when building with docker
FROM ghcr.io/fluxcd/flux-cli:v2.3.0 as flux
FROM registry.hub.docker.com/library/docker:dind as docker
FROM public.ecr.aws/spacelift/runner-terraform:latest

COPY --from=flux /usr/local/bin/flux /usr/local/bin/flux
COPY --from=docker /usr/local/bin/docker /usr/local/bin/docker

RUN flux --version && docker --version