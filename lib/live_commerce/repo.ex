defmodule LiveCommerce.Repo do
  use Ecto.Repo,
    otp_app: :live_commerce,
    adapter: Ecto.Adapters.Postgres
end
