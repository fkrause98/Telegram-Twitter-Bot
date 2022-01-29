defmodule Bot.MixProject do
  use Mix.Project

  def project do
    [
      app: :bot,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Bot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  def deps do
    [
      {:lettuce, "~> 0.1.0", only: :dev},
      # {:telegram, git: "https://github.com/visciang/telegram.git", tag: "0.8.0"},
      {:ex_gram, "~> 0.26"},
      {:tesla, "~> 1.2"},
      {:hackney, "~> 1.12"},
      {:jason, ">= 1.0.0"}
    ]
  end
end
