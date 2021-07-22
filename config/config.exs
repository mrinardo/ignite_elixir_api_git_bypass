# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :api_git,
  ecto_repos: [ApiGit.Repo]

# Configures the endpoint
config :api_git, ApiGitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3EXWkjF+6jB59ZpeHLxaBlzKly5WDldWaTBTM8mNCPWecLqI6wayO2eikhAhS6J1",
  render_errors: [view: ApiGitWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiGit.PubSub,
  live_view: [signing_salt: "RBwzYkkd"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
