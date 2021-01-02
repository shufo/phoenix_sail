defmodule Mix.Tasks.Sail.Install do
  @moduledoc "Printed when the user requests `mix help echo`"
  @shortdoc "Echoes arguments"

  use Mix.Task
  require Logger

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
    Logger.info("./priv/phoenix_sail created")
    File.write!("./docker-compose.yml", get_docker_compose_body(repo_config))
    Logger.info("./docker-compose.yml created")
    File.cp_r(@runtime, "./priv/phoenix_sail/runtime")
    File.cp_r(@bin_file, "./priv/sail")
    Logger.info("./priv/sail created")
    Logger.info(~s(Install finished!

=> Run the following command to add alias to your shell:

echo 'alias sail="priv/sail"' >> ~/.bashrc
source ~/.bashrc

or for zsh

echo 'alias sail="priv/sail"' >> ~/.zshrc
source ~/.zshrc

e.g. $ sail up -d
))
  end

  defp get_docker_compose_body(repo_config) do
    File.read!(@docker_compose_file)
    |> String.replace("#_DB_DATABASE_#", repo_config[:database])
    |> String.replace("#_DB_USERNAME_#", repo_config[:username])
    |> String.replace("#_DB_PASSWORD_#", repo_config[:password])
  end
end
