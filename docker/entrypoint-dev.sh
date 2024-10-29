#!/bin/sh

cd /app

mix deps.get
mix deps.compile
mix ecto.create
mix ecto.migrate
mix ecto.setup

PORT=$APP_PORT elixir --sname app@$APP_CLUSTER_NAME --cookie $APP_CLUSTER_COOKIE -S mix phx.server
