defmodule Mix.Tasks.Sail.Install do
  @moduledoc "Printed when the user requests `mix help echo`"
  @shortdoc "Echoes arguments"

  use Mix.Task

  @impl Mix.Task
  @runtime Application.app_dir(:phoenix_sail, "priv/phoenix_sail/runtime")
  @docker_compose_file Application.app_dir(:phoenix_sail, "priv/phoenix_sail/docker-compose.yml")
  @bin_file Application.app_dir(:phoenix_sail, "priv/phoenix_sail/sail")

  def run(_args) do
    app_name = Mix.Project.config() |> Keyword.get(:app)
    configs = Application.get_all_env(app_name)
    [ecto_repo] = configs |> Keyword.get(:ecto_repos)
    repo_config = configs |> Keyword.get(ecto_repo)

    File.mkdir_p("./priv/phoenix_sail")
    File.write!("./docker-compose.yml", get_docker_compose_body(repo_config))
    File.cp_r(@runtime, "./priv/phoenix_sail/runtime")
    File.cp_r(@bin_file, "./priv/sail")
  end

  defp get_docker_compose_body(repo_config) do
    File.read!(@docker_compose_file)
    |> String.replace("#_DB_DATABASE_#", repo_config[:database])
    |> String.replace("#_DB_USERNAME_#", repo_config[:username])
    |> String.replace("#_DB_PASSWORD_#", repo_config[:password])
  end
end
