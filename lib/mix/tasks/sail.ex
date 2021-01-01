# defmodule Mix.Tasks.Sail do
#   @moduledoc "Printed when the user requests `mix help echo`"
#   @shortdoc "Echoes arguments"

#   use Mix.Task

#   @impl Mix.Task
#   @root File.cwd!()

#   def run(["up" | tail] = _args) do
#     cmd = ["docker-compose up" | tail] |> Enum.join("\s")

#     Mix.shell().cmd(cmd,
#       env: default_env()
#     )
#   end

#   def run(["iex" | _tail] = _args) do
#     app_service = System.get_env("APP_SERVICE", "phoenix.test")

#     port =
#       Port.open({:spawn, "docker-compose exec #{app_service} iex"}, [:nouse_stdio, :exit_status])

#     receive do
#       {^port, {:exit_status, exit_status}} -> IO.puts("sail iex exited with #{exit_status}")
#     end
#   end

#   def run(["shell" | _tail] = _args) do
#     app_service = System.get_env("APP_SERVICE", "phoenix.test")

#     port =
#       Port.open({:spawn, "docker-compose exec #{app_service} bash"}, [:nouse_stdio, :exit_status])

#     receive do
#       {^port, {:exit_status, exit_status}} -> IO.puts("sail shell exited with #{exit_status}")
#     end
#   end

#   def run(args) do
#     cmd = ["./priv/sail" | args] |> Enum.join("\s")
#     Mix.shell().cmd(cmd, env: default_env())
#   end

#   def default_env() do
#     rootDir =
#       File.cwd!()
#       |> Path.basename()

#     [
#       {"DB_DATABASE", "#{rootDir}_dev"},
#       {"DB_HOST", "mysql"},
#       {"REDIS_PORT", "6379"},
#       {"DB_PORT", "3306"}
#     ]
#   end
# end
