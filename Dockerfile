# Stage 1: Flutter Web build
FROM debian:bookworm-slim AS builder

# Install system dependencies and Sentry CLI
RUN apt-get update && apt-get install -y git curl unzip xz-utils && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://sentry.io/get-cli/ | bash

ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter config --enable-web

WORKDIR /app
COPY . .

RUN flutter clean

# Build with source maps
ARG SENTRY_RELEASE
ARG SENTRY_DIST
ARG SENTRY_AUTH_TOKEN
ARG SENTRY_ORG
ARG SENTRY_PROJECT

ENV SENTRY_AUTH_TOKEN=${SENTRY_AUTH_TOKEN}
ENV SENTRY_ORG=${SENTRY_ORG}
ENV SENTRY_PROJECT=${SENTRY_PROJECT}
ENV SENTRY_RELEASE=${SENTRY_RELEASE}
ENV SENTRY_DIST=${SENTRY_DIST}

RUN flutter pub get && flutter build web \
    --release \
    --source-maps \
    --base-href "/flutter_web_sentry/" \
    --dart-define=SENTRY_RELEASE=${SENTRY_RELEASE} \
    --dart-define=SENTRY_DIST=${SENTRY_DIST}

# Inject debugId
RUN sentry-cli sourcemaps inject ./build/web --ext js --ext mjs --ext map

# Upload source maps to Sentry
RUN sentry-cli releases --org "$SENTRY_ORG" --project "$SENTRY_PROJECT" new "$SENTRY_RELEASE" && \
    sentry-cli releases --org "$SENTRY_ORG" --project "$SENTRY_PROJECT" files "$SENTRY_RELEASE" upload-sourcemaps ./build/web \
      --ext js --ext mjs --ext map --rewrite --dist "$SENTRY_DIST" && \
    sentry-cli releases --org "$SENTRY_ORG" --project "$SENTRY_PROJECT" finalize "$SENTRY_RELEASE"

# Stage 2: Export build only (no nginx, for GitHub Pages)
FROM alpine:3.18 AS export
WORKDIR /dist
COPY --from=builder /app/build/web .
