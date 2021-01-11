defmodule PhoenixSail.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_sail,
      version: "0.1.0",
      elixir: "~> 1.11",
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    A Docker powered local environment for Phoenix
    """
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*", "priv"],
      maintainers: ["Shuhei Hayashibara"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/shufo/phoenix_sail",
        "Docs" => "https://hexdocs.pm/phoenix_sail"
      }
    ]
  end
end
