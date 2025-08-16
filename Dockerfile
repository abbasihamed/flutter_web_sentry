# ---------- Stage 1: Build Flutter Web ----------
ARG FLUTTER_VERSION=stable
FROM ghcr.io/cirruslabs/flutter:${FLUTTER_VERSION} AS builder
WORKDIR /app

RUN flutter config --enable-web

# Caching: اول فقط pubspec ها
COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get

# بقیه سورس
COPY . .

# Build args از CI می‌آیند
ARG BASE_HREF=/
ARG SENTRY_DSN=
ARG SENTRY_RELEASE=
ARG SENTRY_ENV=production

# Release build + sourcemaps + dart-define ها
RUN flutter build web --release \
    --source-maps \
    --dart-define=SENTRY_DSN=${SENTRY_DSN} \
    --dart-define=SENTRY_RELEASE=${SENTRY_RELEASE} \
    --dart-define=SENTRY_ENV=${SENTRY_ENV}

# ---------- Stage 2: Artifact for GitHub Pages ----------
FROM scratch AS artifact
COPY --from=builder /app/build/web/ /

# ---------- Stage 3: Optional Nginx runtime ----------
# FROM nginx:alpine AS runtime
# COPY --from=builder /app/build/web /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
