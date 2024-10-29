FROM elixir:1.17.0-otp-27-alpine AS build

RUN apk add --no-cache build-base git
RUN apk add inotify-tools
RUN apk add imagemagick
RUN apk add --no-cache jpeg-dev libpng-dev libwebp-dev tiff-dev libavif-dev libheif-dev

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . .

COPY entrypoint-dev.sh /usr/local/bin/entrypoint-dev.sh

RUN chmod +x /usr/local/bin/entrypoint-dev.sh

CMD ["/usr/local/bin/entrypoint-dev.sh"]
