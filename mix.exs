defmodule Doubler.Mixfile do
  use Mix.Project

  def project do
    [app: :doubler,
     version: "0.0.1",
     elixir: "~> 1.5.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:cowboy, :eex, :logger, :plug, :poison, :vex],
     mod: {Main,[]}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:distillery, "~> 1.4", runtime: false},
     {:cowboy, "~> 1.1.2"},
     {:plug, "~> 1.3.5"},
     {:poison, "~> 3.1.0"},
     {:vex, "~> 0.6.0"}]
  end

end
