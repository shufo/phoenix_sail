defmodule Mix.Tasks.Sail.Install do
  @moduledoc "Printed when the user requests `mix help echo`"
  @shortdoc "Echoes arguments"

  use Mix.Task

  @impl Mix.Task
  @runtime Application.app_dir(:phoenix_sail, "priv/phoenix_sail/runtime")
  @docker_compose_file Application.app_dir(:phoenix_sail, "priv/phoenix_sail/docker-compose.yml")
  @docker_files Application.app_dir(:phoenix_sail, "priv/phoenix_sail/runtime")
  @bin_file Application.app_dir(:phoenix_sail, "priv/phoenix_sail/sail")

  def run(args) do
    File.mkdir_p("./priv/phoenix_sail")
    File.copy(@docker_compose_file, "./docker-compose.yml")
    File.cp_r(@runtime, "./priv/phoenix_sail/runtime")
    File.cp_r(@bin_file, "./priv/sail")
  end
end
