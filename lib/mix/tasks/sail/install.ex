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
    File.write!("./docker-compose.yml", get_docker_compose_body())
    File.cp_r(@runtime, "./priv/phoenix_sail/runtime")
    File.cp_r(@bin_file, "./priv/sail")
  end

  defp get_docker_compose_body() do
    database_name = database_name()
    IO.puts("DB name specified: #{database_name}")

    File.read!(@docker_compose_file)
    |> String.replace("#_DB_DATABASE_#", database_name)
  end

  defp database_name() do
    rootDir =
      File.cwd!()
      |> Path.basename()

    case Mix.shell().prompt("Database Name [#{rootDir}]: ") do
      "\n" -> rootDir
      x -> x
    end
  end
end
