[
  import_deps: [:ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations"],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs:
    Enum.flat_map(
      [
        "*.{heex,ex,exs}",
        "{mix,.formatter}.exs",
        "{config,lib,test}/**/*.{ex,exs}",
        "priv/*/seeds.exs"
      ],
      &Path.wildcard(&1, match_dot: true)
    ) -- ["scratch.ex", "table_components.ex"]
]
